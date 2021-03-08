import { Socket } from 'phoenix';
let socket = new Socket('/socket', { params: { token: window.userToken } });

socket.connect();

const createSocket = topicId => {
  let channel = socket.channel(`comments:${topicId}`, {});
  channel.join()
    .receive('ok', resp => {
      console.log(resp); renderComments(resp.comments);
    })
    .receive('error', resp => {
      console.log('Unable to join', resp);
    });
  /*Ouvinte do canal que vem do broadcast em comments_channel*/ 
  channel.on(`comments:${topicId}:new`, renderComment);

  document.querySelector('button').addEventListener('click', () => {
    const content = document.querySelector('textarea').value;

    channel.push('comment:add', { content: content });
  });
};
/*Usada para rendenrizar uma lista de comentários */
function renderComments(comments) {
  const renderedComments = comments.map(comment => {
    return commentTemplate(comment);
  });

  document.querySelector('.collection').innerHTML = renderedComments.join('');
}
/*Renderiza um único comentário enviado por último e adiciona a lista existente aqui,
passando um evento de comentário*/
function renderComment(event) {
  const renderedComment = commentTemplate(event.comment);

  document.querySelector('.collection').innerHTML += renderedComment;
}
/*Modelo de comentário com um comentário, recebendo de volta o tópico renderizado e imprime na tela*/
function commentTemplate(comment) {
  let email = 'Anônimo';
  if (comment.user) {
    email = comment.user.email;
  }
  return `
    <li class="collection-item">
      ${comment.content}
      <div class="secondary-content">
        ${email}
      </div>
    </li>
  `;
}

window.createSocket = createSocket;