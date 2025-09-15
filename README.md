# 🔧 Configuração do Projeto

## 📋 Pré-requisitos

1. [Dart SDK](https://dart.dev/get-dart) instalado
2. Conta gratuita na [WeatherAPI](https://www.weatherapi.com/)

## 🚀 Configuração Passo a Passo

### 1. **Criar o projeto**
```bash
dart create weather_app
cd weather_app
```

### 2. **Criar estrutura de pastas**
```bash
# Linux/macOS
mkdir -p lib/models lib/services lib/config

# Windows (PowerShell)
mkdir lib\models, lib\services, lib\config

# Windows (Command Prompt)
mkdir lib\models
mkdir lib\services  
mkdir lib\config
```

### 3. **Configurar API Key**

#### 3.1. Obter API Key
1. Acesse [WeatherAPI.com](https://www.weatherapi.com/)
2. Crie uma conta gratuita
3. Copie sua API Key do dashboard

#### 3.2. Configurar arquivo de API
```bash
# Copie o arquivo de exemplo
cp lib/config/api_config.example.dart lib/config/api_config.dart

# Ou no Windows
copy lib\config\api_config.example.dart lib\config\api_config.dart
```

#### 3.3. Editar o arquivo de configuração
Abra `lib/config/api_config.dart` e substitua:
```dart
static const String weatherApiKey = 'SUA_CHAVE_API_REAL_AQUI';
```

### 4. **Instalar dependências**
```bash
dart pub get
```

### 5. **Executar o projeto**
```bash
dart run bin/main.dart
```

## 🔐 Segurança

- ✅ O arquivo `api_config.dart` está no `.gitignore`
- ✅ Suas credenciais NÃO serão commitadas
- ✅ O arquivo `api_config.example.dart` serve como template

## 📁 Estrutura Final

```
weather_app/
├── .gitignore
├── SETUP.md
├── README.md
├── pubspec.yaml
├── bin/
│   └── main.dart
└── lib/
    ├── config/
    │   ├── api_config.dart          # ← Suas credenciais (não commitado)
    │   └── api_config.example.dart  # ← Template (commitado)
    ├── models/
    │   └── weather_data.dart
    ├── services/
    │   └── weather_service.dart
    └── weather_app.dart
```

## 🆘 Troubleshooting

### Erro: "api_config.dart não encontrado"
```bash
# Certifique-se de copiar o arquivo exemplo
cp lib/config/api_config.example.dart lib/config/api_config.dart
```

### Erro: "Invalid API key"
- Verifique se copiou a API key corretamente
- Confirme que a conta está ativa no WeatherAPI
- Tente gerar uma nova API key

### Erro: "No such file or directory"
- Certifique-se de estar na pasta raiz do projeto
- Verifique se todas as pastas foram criadas

## ✅ Verificação

Para confirmar que está tudo funcionando:
1. Execute `dart run bin/main.dart`
2. Escolha opção 1 (clima atual)
3. Digite uma cidade (ex: "London")
4. Deve retornar os dados do clima

## 🤝 Colaboração

Para outros desenvolvedores que clonarem o repositório:

1. **Clone o projeto**
2. **Copie o arquivo de configuração**: `cp lib/config/api_config.example.dart lib/config/api_config.dart`
3. **Configure sua própria API key**
4. **Execute**: `dart pub get && dart run bin/main.dart`

---

⚠️ **IMPORTANTE**: Nunca commite arquivos com API keys reais!