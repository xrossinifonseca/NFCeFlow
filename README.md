# Trackmaino - Sistema de processamentos NFCEs


Este projeto é um sistema que permite o upload de arquivos XML e ZIP contendo notas fiscais. O sistema processa esses arquivos em segundo plano usando Sidekiq e gera relatórios detalhados das notas processadas. O sistema foi construído com Ruby on Rails, Nokogiri para parsear os XMLs, Devise para autenticação, e TailwindCSS para o frontend.

## Funcionalidades

- **Autenticação de Usuários**: Sistema de login e registro de usuários utilizando Devise.
- **Upload de Arquivos**: Suporte para upload de arquivos XML e ZIP contendo NFCes.
- **Processamento em Segundo Plano**: As notas fiscais são processadas em background utilizando Sidekiq, garantindo uma experiência fluida para o usuário.
- **Geração de Relatórios**: Após o processamento, o sistema gera relatórios detalhados das notas fiscais, incluindo:
  - Filtro por período das notas.
  - Busca de notas por número.
  - Busca de notas por destinatário através do CNPJ.
- **Exportação para Excel**: Os relatórios e dados das notas fiscais podem ser exportados para arquivos Excel para análise e arquivamento.


## Tecnologias Utilizadas

- **Ruby on Rails**: Framework principal utilizado para o desenvolvimento do sistema.
- **Sidekiq**: Ferramenta de processamento em background, usada para processar os arquivos de notas fiscais.
- **Nokogiri**: Biblioteca Ruby para parsear e extrair dados de arquivos XML.
- **RubyZip**: Biblioteca para manipulação de arquivos ZIP, permitindo o upload de múltiplos XMLs compactados.
- **TailwindCSS-Rails**: Framework CSS utilizado para estilização do frontend.
- **Devise**: Gem utilizada para autenticação de usuários.
- **PostgreSQL**: Banco de dados relacional utilizado para armazenar as informações do sistema.
 
## Como Utilizar

### Pré-requisitos

- Ruby 3.x.x
- Rails 7.x.x
- Redis (necessário para o Sidekiq)
- PostgreSQL

### Instalação

1. Clone o repositório:

    ```bash
     git clone https://github.com/xrossinifonseca/trackmaino.git
 
    ```

2. Instale as dependências:

    ```bash
    bundle install
    ```

3. Instale o TailwindCSS:

    ```bash
    rails tailwindcss:install
    ```

4. Configure o banco de dados:

    ```bash
    rails db:create db:migrate 
    ```

5. Inicie o servidor:

    ```bash
    rails server
    ```

6. Inicie o Sidekiq para processar os arquivos em segundo plano:

    ```bash
    bundle exec sidekiq
    ```

### Uso

1. **Registro e Login**: Acesse o sistema e crie uma conta ou faça login.
2. **Upload de NFCes**: Navegue até a seção de uploads e envie seus arquivos XML ou ZIP contendo as notas fiscais.
3. **Relatórios**: Acesse a seção de relatórios para visualizar e filtrar as notas processadas.

## Testes

Execute os testes para garantir que tudo esteja funcionando corretamente:

```bash
rspec
```
## Desafio
O maior desafio neste projeto foi processar as notas fiscais a partir de arquivos ZIP. Inicialmente, considerei estruturar a lógica armazenando os arquivos extraídos temporariamente em uma pasta dentro do projeto. No entanto, essa abordagem mostrou-se inadequada para o ambiente de produção, onde o armazenamento de arquivos temporários poderia causar problemas de performance e segurança.

Para superar esse obstáculo, decidi modificar a estratégia, mantendo os arquivos em memória até que o Sidekiq processasse cada arquivo individualmente. Após a extração completa do conteúdo do arquivo ZIP, o processamento foi realizado de forma eficiente, sem a necessidade de armazenamento intermediário no sistema de arquivos, o que garantiu uma solução mais segura e escalável.

## Modelagem do Banco de Dados

A estrutura do banco de dados foi cuidadosamente projetada para suportar as funcionalidades principais do sistema, como o armazenamento de notas fiscais, a relação entre clientes, emissores, destinatários, e os detalhes fiscais de cada nota. A modelagem foi realizada com o objetivo de otimizar consultas e garantir a integridade dos dados.

### Estrutura das Tabelas

- **Customer**: Armazena as informações dos usuários do sistema, como nome, e-mail e senha.
- **Upload**: Registra os uploads de arquivos XML e ZIP feitos pelos usuários, incluindo o status do processamento.
- **Nfce**: Armazena as informações das notas fiscais eletrônicas, como série, número da nota, data de emissão, valores totais, e relaciona-se com outras tabelas como `Issuer`, `Recipient` e `Tax`.
- **Issuer**: Contém os dados dos emissores das notas fiscais.
- **Recipient**: Armazena os dados dos destinatários das notas fiscais.
- **Product**: Mantém informações sobre os produtos incluídos nas notas fiscais.
- **Tax**: Guarda os detalhes fiscais associados a cada nota, como valores de ICMS, PIS, COFINS e IPI.
- **Nfce_Product**: Faz a relação entre as notas fiscais e os produtos, armazenando a quantidade comercializada, o valor unitário, e os impostos específicos.

### Diagrama do Banco de Dados

![schema](https://github.com/user-attachments/assets/ebef2430-916c-4838-b2b6-10b56dd17c44)

### Deploy
- **O sistema está disponível online no seguinte link:**
- https://trackmaino.onrender.com








