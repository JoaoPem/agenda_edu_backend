# 📚 Agenda Edu Backend

Este é o backend do **Agenda Edu**, um sistema desenvolvido para facilitar a comunicação entre escolas, alunos e responsáveis. A aplicação permite o gerenciamento completo do ambiente escolar de forma tecnológica e eficiente.

## 🛠️ Pré-requisitos

- Certifique-se de ter o **Docker** instalado em sua máquina.
- Certifique-se de ter o **Git** instalado para clonar o repositório.

## 🚀 Passo a Passo

1. **Clone o repositório:**  
   Abra o terminal e clone o repositório:

   ```bash
   git clone https://github.com/JoaoPem/agenda_edu_backend.git
2.  **Acesse o Projeto:**
    ```bash 
    cd agenda_edu_backend
3.  **Inicie o Container:**
    Isso iniciará todos os serviços definidos no docker-compose.yml, incluindo o banco de dados e a aplicação Rails.
    ```bash 
    docker-compose up -d
4.  **Liste os containers em execução para obter o CONTAINER_ID do projeto:**
    ```bash 
    docker ps
5.  **Popule o banco de dados:**
    Após os containers estarem em execução, você pode popular o banco de dados usando a tarefa dev:setup. Para isso, execute o seguinte 
    ```bash 
    docker exec -it <CONTAINER_ID> rails dev:setup
## 💻 Tecnologias Utilizadas
  Ruby on Rails 8.0.1 (API Mode),
  Ruby 3.3.6,
  Docker,
  Git,
  PostgreSQL,
  ActiveModel Serializers,
  Active Storage,
  Active Cable,
  Rack CORS,
  Etag (Caching),
  JWT,
  Gem CanCanCan,
  Bcrypt .
## 📌 Visão Geral do Projeto

Este projeto é um sistema de gestão escolar baseado em API, desenvolvido com Ruby on Rails. O objetivo principal é fornecer um ambiente onde administradores, professores, alunos e responsáveis possam interagir de maneira organizada e eficiente. O sistema permite o gerenciamento de disciplinas, turmas, tarefas e notificações de eventos escolares, garantindo uma comunicação eficaz entre os usuários.

 📜 **Funcionalidades Principais**

1. **Gerenciamento de Usuários**
    O sistema possui diferentes tipos de usuários, definidos pela enum role:

    * **Admin:** Gerencia usuários, disciplinas, assuntos, salas de aula e eventos escolares.

    * **Professor:** Responsável por abrir tarefas e acompanhar as submissões dos alunos.

    * **Aluno:** Visualiza e responde às tarefas, interage com os colegas de sala e recebe feedbacks.

    * **Responsável:** Acompanha notificações e eventos escolares relacionados ao aluno.

2. **Autenticação e Segurança**

    * O sistema utiliza JWT (JSON Web Token) para autenticação dos usuários.

    * Todas as rotas são protegidas e verificadas conforme o tipo de usuário.

    * O ApplicationController gerencia erros comuns, incluindo acesso negado e rotas inexistentes.

3. **Gerenciamento de Disciplinas e Tarefas**

    * Admins podem criar disciplinas (subjects) e assuntos (topics), vinculando-os aos professores.

    * Professores podem criar tarefas (tasks), definir prazos e anexar arquivos PDF.

    * Alunos enviam suas tarefas (task_submissions) e recebem feedbacks.

4. **Comunicação e Notificações**

    * O sistema permite que alunos visualizem os colegas de classe.

    * Eventos escolares são notificados para os responsáveis através de EventNotifications.

    * Utilização do ActionCable para comunicação em tempo real entre professores e alunos.

5. **Controle de Acesso**

    * O projeto usa CanCanCan para gerenciar permissões de cada tipo de usuário:

    * Admins têm controle total sobre o sistema.

    * Professores gerenciam suas tarefas, mas não acessam informações de usuários.

    * Alunos podem interagir apenas com suas atividades e turmas.

    * Responsáveis têm acesso apenas às notificações relacionadas aos seus filhos.

## Agradecimentos & Contato

🚀 Obrigado por conferir este projeto! Se tiver dúvidas ou sugestões, entre em contato:

📧 Email: devjoaomonteiro@gmail.com.br

💼 LinkedIn: João Pedro Monteiro: https://www.linkedin.com/in/jo%C3%A3o-pedro-monteiro-b78059253/

📌 GitHub: João Pedro Monteiro: https://github.com/JoaoPem


