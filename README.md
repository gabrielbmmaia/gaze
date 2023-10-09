# Gaze
O Gaze é um aplicativo que utiliza a TMDB API para obter acesso aos dados necessários. Através dele, é possível visualizar as series que estão em alta em cada plataforma de streaming assim como pesquisar por serie e gêneros específicos. A intenção por trás do desenvolvimento do Gaze foi a de colocar em prática pela primeira vez o Framework Flutter além de também implementar pela primeira vez o Firebase em um aplicativo. 

# Índice 
* [Layouts do Projeto](#layouts-do-projeto)
* [Funcionalidades do projeto](#funcionalidades-do-projeto)
* [Técnicas e tecnologias utilizadas](#técnicas-e-tecnologias-utilizadas)
* [Navegação entre Telas](#navegação-entre-telas)
* [Funcionalidades das Telas](#funcionalidades-das-telas)
* [Api](#api)
* [Abrir e rodar o projeto](#abrir-e-rodar-o-projeto)
* [Showcase do aplicativo](#showcase-do-aplicativo)

# Layouts do Projeto
Aqui é possível visualizar um resumo de todas as telas do aplicativo.
![layout-gaze](https://github.com/gabrielbmmaia/gaze/assets/109977155/a52c332b-8d92-46d5-8e4b-f0dde818e586)

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
`Teste Unitários`: foram feitos teste unitários em todas camadas do app seguindo o TDD. <br>

# Navegação entre Telas
![screen-navigation](https://github.com/gabrielbmmaia/gaze/assets/109977155/efc284b3-2de0-4e15-acca-f53421c18353)

# Funcionalidades das Telas

### Authentication
Nas telas de autenticação é possível logar em uma conta já existente, criar uma conta nova e pedir uma nova senha caso tenha esquecido. Aqui nessas telas a autenticação e armazenamento de novas contas é feita pelo firebase.

![auth_feature](https://github.com/gabrielbmmaia/gaze/assets/109977155/dac79cb3-24d2-407f-a868-36f2430a7abe)

### Home Screen + Details Screen


![home-details](https://github.com/gabrielbmmaia/gaze/assets/109977155/f7010ce7-06a0-4bdd-9f0e-600777dd623c)

### Search Screen
Na tela de Favoritos, o usuário tem acesso a todas as imagens que foram guardadas como favoritas, permitindo-lhe visualizar uma variedade de obras de artistas pelos quais ele demonstrou maior apreço.

![search-screen](https://github.com/gabrielbmmaia/gaze/assets/109977155/5f507be3-1a34-4697-8b27-975c67829897)

### Profile Screen
Na tela "Ver mais", o usuário tem acesso à uma lista de imagens relacionadas à um único artista. Essa features consegue ser acessada ao clicar em "+ ver mais" em algum Card de Foto no aplicativo.

![profile](https://github.com/gabrielbmmaia/gaze/assets/109977155/e73c50ec-e0e9-4992-81aa-ee92e82e9a8a)

# Api
[https://unsplash.com/documentation](https://developer.themoviedb.org/reference/intro/getting-started) ( utilizada 20/09/2023 )

# Abrir e rodar o projeto

### Pela APK: <br>
Para baixar a APK do aplicativo é só você clicar em (Gaze App) dentro de Releases localizado na direita da página ou caso estaja no celular ficará localizado logo abaixo do Readme do projeto. Clicando em Gaze App três arquivos aparecerão e clique em "app-release.apk" e depois em Baixar. Caso não esteja permitido o celular baixar aplicativos por outras fontes sem ser a PlayStore será necessário permitir em configurações. Após isso é só abrir e se divertir.

### Pelo Android Studio: <br>
Após baixar o projeto, você pode abrir com o Android Studio. Para isso, na tela de launcher clique em:
Open an Existing Project (ou alguma opção similar) Procure o local onde o projeto está e o selecione (Caso o projeto seja baixado via zip, é necessário extraí-lo
antes de procurá-lo) Por fim clique em OK, O Android Studio deve executar algumas tasks do Gradle para configurar o projeto, aguarde até finalizar. Ao finalizar as 
tasks, você pode executar o App.

# Showcase do aplicativo
<div align="center">
 <video src=https://github.com/gabrielbmmaia/gaze/assets/109977155/5402cb60-b5f8-44b1-a3a2-820072afee5f width=800/>
<div/>




