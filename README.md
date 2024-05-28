# Star Wars App
Este é um projeto de aplicativo móvel desenvolvido em Flutter que utiliza a API de Star Wars para fornecer informações sobre personagens, planetas e filmes da famosa saga. O aplicativo foi desenvolvido seguindo os princípios do clean architecture e utiliza diversas tecnologias para fornecer uma experiência robusta e eficiente para o usuário.

O desenvolvimento do aplicativo Star Wars foi organizado utilizando o Trello. Você pode acessar o board [clicando aqui](https://trello.com/invite/b/6IgGNNqr/ATTIaddce879745bf2c3fdaacbd41fbf2af09E7626EA/aplicativo-de-informacoes-star-wars).


## Arquitetura
O projeto segue o clean architecture, que é composta por três camadas principais:

* Camada de Apresentação (Presentation Layer): Esta camada é responsável por exibir a interface do usuário e interagir com o usuário final. Ela inclui todos os componentes de UI, como telas, widgets, cubits (gerenciadores de estado), e é onde ocorre a injeção de dependência para acessar os casos de uso.

* Camada de Domínio (Domain Layer): A camada de domínio contém toda a lógica de negócios e regras de domínio da aplicação. Aqui são definidos os casos de uso e os modelos de dados que representam os conceitos fundamentais da aplicação, como Personagem, Planeta e Filme.

* Camada de Infraestrutura (Infrastructure Layer): Esta camada lida com os detalhes técnicos da implementação, como acesso a dados externos, armazenamento local, autenticação, etc. Aqui são implementadas as classes que se comunicam com a API de Star Wars, o armazenamento local usando o SharedPreferences e a autenticação usando o Firebase.

## Tecnologias Utilizadas
* Cubit: Utilizado para gerenciamento de estado na camada de apresentação, permitindo uma gestão eficiente do estado da aplicação e uma separação clara entre a lógica de negócios e a interface do usuário.

* SharedPreferences: Utilizado para armazenamento local dos dados da API de Star Wars, garantindo que as informações sejam acessadas de forma rápida e eficiente, e evitando a necessidade de fazer requisições repetidas à API.

* GetIt: Utilizado para injeção de dependência, facilitando a organização e o acesso aos objetos necessários em toda a aplicação.

* Firebase Authentication: Utilizado para autenticação de usuários, fornecendo uma maneira segura e confiável de gerenciar a identidade dos usuários e proteger o acesso aos recursos do aplicativo.

## Funcionalidades
Visualização de informações sobre personagens, planetas e filmes de Star Wars.
Favoritar personagens, planetas e filmes para acessá-los facilmente posteriormente.
Autenticação de usuários usando Firebase Authentication, permitindo que os usuários acessem recursos exclusivos e mantenham suas informações personalizadas.

## Estado Atual do Projeto
O projeto está em um estado funcional, porém ainda há alguns aspectos a serem finalizados. O que ficou faltando terminar foi a implementação de testes completos para todas as partes do aplicativo.  Além de implementar os testes completos, uma melhoria que também poderia ser feita é aprimorar o layout do aplicativo. Um layout intuitivo e atraente pode melhorar significativamente a experiência do usuário, tornando a navegação mais fluida e agradável. 

Você pode ver o progresso atual e as tarefas pendentes no board do Trello.


![Alt Text](assets/images/starwarsapp.gif)


