# Gaze
[EM PRODUÇÂO]
O PicView é um aplicativo que utiliza a Unsplash API para obter acesso aos dados necessários. Através dele, é possível visualizar uma ampla variedade de fotografias disponibilizadas por artistas no site da Unsplash. A intenção por trás do desenvolvimento do PicView foi a de colocar em prática a modularização de um aplicativo, bem como a vontade de construir um aplicativo completamente novo utilizando o Jetpack Compose.

# Índice 
[EM PRODUÇÂO]
* [Layouts do Projeto](#layouts-do-projeto)
* [Funcionalidades do projeto](#funcionalidades-do-projeto)
* [Técnicas e tecnologias utilizadas](#técnicas-e-tecnologias-utilizadas)
* [Funcionalidades do Card de Foto](#funcionalidades-do-card-de-foto)
* [Navegação entre Features](#navegação-entre-features)
* [Features](#features)
* [Api](#api)
* [Abrir e rodar o projeto](#abrir-e-rodar-o-projeto)
* [Showcase do aplicativo](#showcase-do-aplicativo)

# Layouts do Projeto
Aqui é possível visualizar um resumo de todas as telas do aplicativo.
![layout-gaze](https://github.com/gabrielbmmaia/gaze/assets/109977155/693e89d0-452c-4fd2-bf23-49bcde5740b7)


# Funcionalidades do projeto
`Listar series mais populares da TMDB` <br>
`Listar series mais populares da Netflix` <br>
`Listar series mais populares da Amazon` <br>
`Listar series mais populares da HBO Max` <br>
`Listar series mais populares da Disney+` <br>
`Listar series mais populares da Apple TV+` <br>
`Listar series bem avaliadas da TMDB` <br>
`Listar as top 10 trending series da TMDB` <br>
`Pesquisar por uma serie específica pelo nome` <br>
`Pesquisar por series de um único gênero` <br>
`Ver os detalhes de uma serie` <br>
`Navegar para o Youtube para assistir uma mídia da série` <br>
`Cria conta` <br>
`Fazer Login` <br>
`Fazer Logout` <br>
`Ferramenta de esqueci a senha` <br>
`Editar seu perfil` <br>
`Adicionar series à sua lista de favoritos` <br>

# Técnicas e tecnologias utilizadas
`Flutter`: foi escolhido o framework Flutter para construir um app híbrido. <br>
`Dart`: linguagem utilizada no projeto. <br>
`Git`: usado para versionar o código no github. <br>
`Http`: usado para pegar dados da TMDB Api. <br>
`Provider`: usado para prover algumas instâncias. <br>
`Shared Preferences`: usado para indicar que o usuário já está logado no app. <br>
`Url Launcher`: usado para enviar o usuário para o Youtube ao clicar em uma mídia. <br>
`Image Picker`: Usado para o usuário escolher uma imagem em seu perfil. <br>
`Firebase`: foi utilizado para armazenas todos os dados do aplicativo. Foi usando Authtentication, Cloud Firestore, Storage <br>
`Bloc`: foi escolhido para fazer o gerenciamento de estados. <br>
`Get_it`: usado para injeção de dependência. <br>
`Clean Archtecture`: projeto foi feito totalmente na Clean Archtecture. <br>
`Lottie`: utilizado para animação de algumas imagens. <br>

# Navegação entre Telas
![screen-navigation](https://github.com/gabrielbmmaia/gaze/assets/109977155/efc284b3-2de0-4e15-acca-f53421c18353)

# Features

### Splash
A Splash Screen exibe uma seleção de 5 imagens animadas distintas, fornecendo uma variedade de opções ao iniciar o aplicativo.

![splash-screen-fox](https://github.com/gabrielbmmaia/PicView/assets/109977155/24cde29d-43ca-4c4f-be4b-b4b44971dbc8)
![splash-screen-mountain](https://github.com/gabrielbmmaia/PicView/assets/109977155/7aff006e-82dc-49a2-93b6-8a32ce7ced5a)
![splash-screen-forest](https://github.com/gabrielbmmaia/PicView/assets/109977155/d22dbe30-afa5-4b06-a6b6-81a5f0576450)
![splash-screen-coffee](https://github.com/gabrielbmmaia/PicView/assets/109977155/13428386-d8cb-4f8f-bc0c-57b7f0497a7c)
![splash-screen-cat](https://github.com/gabrielbmmaia/PicView/assets/109977155/dbfa8586-722d-43a1-93b6-de8f5e46163c)

### Home
A tela inicial apresenta uma lista de fotografias que são regularmente atualizadas pela Unsplash API, exibindo as imagens mais recentes disponíveis. Nessa tela, o usuário tem a capacidade de explorar uma variedade de fotografias de diversos artistas e categorias.

![home-screen](https://github.com/gabrielbmmaia/PicView/assets/109977155/9a6f87d4-44af-46b7-83c2-680e851cda36)

### Search
Na tela de pesquisa, os usuários têm a capacidade de realizar pesquisas de imagens associadas a palavras-chave específicas. Além disso, é possível aplicar um filtro de cor que será utilizado para filtrar as imagens exibidas com base na cor selecionada.

![feature-search](https://github.com/gabrielbmmaia/PicView/assets/109977155/c12e9de8-4537-4560-866a-17fc05513f38)

### Favorite
Na tela de Favoritos, o usuário tem acesso a todas as imagens que foram guardadas como favoritas, permitindo-lhe visualizar uma variedade de obras de artistas pelos quais ele demonstrou maior apreço.

![favorite-screen](https://github.com/gabrielbmmaia/PicView/assets/109977155/8240b627-4e6f-444b-8936-f9b3b8300be5)

### See More
Na tela "Ver mais", o usuário tem acesso à uma lista de imagens relacionadas à um único artista. Essa features consegue ser acessada ao clicar em "+ ver mais" em algum Card de Foto no aplicativo.

![see-more-screen](https://github.com/gabrielbmmaia/PicView/assets/109977155/e0ed0b61-778d-4dd3-b052-69d6c2b929b5)

# Api
https://unsplash.com/documentation ( utilizada 03/06/2023 )

# Abrir e rodar o projeto

### Pela APK: <br>
Para baixar a APK do aplicativo é só você clicar em PicView dentro de Releases localizado na direita da página ou caso estaja no celular ficará localizado logo abaixo do Readme do projeto. Clicando em PicView três arquivos aparecerão e clique em "pic-view.apk" e depois em Baixar. Caso não esteja permitido o celular baixar aplicativos por outras fontes sem ser a PlayStore será necessário permitir em configurações. Após isso é só abrir e se divertir.

### Pelo Android Studio: <br>
Após baixar o projeto, você pode abrir com o Android Studio. Para isso, na tela de launcher clique em:
Open an Existing Project (ou alguma opção similar) Procure o local onde o projeto está e o selecione (Caso o projeto seja baixado via zip, é necessário extraí-lo
antes de procurá-lo) Por fim clique em OK, O Android Studio deve executar algumas tasks do Gradle para configurar o projeto, aguarde até finalizar. Ao finalizar as 
tasks, você pode executar o App.

# Showcase do aplicativo
<div align="center">
 <video src=https://github.com/gabrielbmmaia/PicView/assets/109977155/8f4e7a6c-462d-423c-80b8-82667ee1ff4a width=800/>
<div/>
