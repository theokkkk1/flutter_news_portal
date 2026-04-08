# 📰 Sponews – Portal de Notícias Esportivas

Aplicativo mobile desenvolvido com Flutter para consumo e exibição de notícias esportivas em tempo real, com foco em performance, organização de código e boa experiência do usuário.

---

## 🚀 Funcionalidades

* 📡 Consumo de API de notícias esportivas
* 📰 Listagem dinâmica de notícias
* 🔍 Tela de detalhes com conteúdo completo
* ⭐ Sistema de favoritos
* ⚙️ Tela de configurações
* 🔄 Tratamento de estados (loading, erro e sucesso)
* 🧭 Navegação com rotas nomeadas

---

## 🛠️ Tecnologias Utilizadas

* Flutter
* Dart
* HTTP (consumo de API)
* Gerenciamento de estado (setState / FutureBuilder)

---

## 🧠 Conceitos Aplicados

* Consumo de APIs REST
* Separação de responsabilidades
* Componentização de widgets
* Tratamento de erros e estados da aplicação
* Navegação entre telas

---

## 📱 Estrutura do Projeto

```
lib/
 ├── models/        # Modelos de dados (notícias)
 ├── services/      # Consumo de API
 ├── screens/       # Telas do app
 ├── widgets/       # Componentes reutilizáveis
 └── main.dart      # Ponto de entrada
```

---

## 📊 Objetivo do Projeto

Este projeto foi desenvolvido com o objetivo de praticar o desenvolvimento mobile utilizando Flutter, com foco em aplicações que consomem dados externos e apresentam informações de forma organizada e interativa para o usuário.

---

## ▶️ Como Executar

1. Clone o repositório:

```
git clone https://github.com/seu-usuario/sponews.git
```

2. Acesse a pasta do projeto:

```
cd sponews
```

3. Instale as dependências:

```
flutter pub get
```

4. Execute o app:

```
flutter run
```

---

## 📌 Melhorias Futuras

* 💾 Persistência de favoritos (SQLite ou SharedPreferences)
* 🔎 Sistema de busca de notícias
* 🌙 Tema dark mode
* 📡 Cache de dados para uso offline

---
