# Grupo Zap - Code Challenge
Projeto desenvolvido para iOS utiliando a linguagem Swift 4. Possuí testes unitários para as regras de negócio (ex: preço mínimo etc).

O projeto é compatível com iPhone 6 ou superior e iPad Air ou superior. Apesar de suportar iPad, o projeto não possuí interfaces específicas para esta plataforma.

## Requisitos

* Xcode 10.1
* CocoaPods 1.6.0

## Instalação

Para rodar o projeto localmente, é preciso baixar o projeto e instalar suas dependencias, para isso basta abrir um terminal na pasta de destino desejada e executar os comandos abaixo:  

```
git clone git@github.com:educobuci/zap-code-challenge.git
cd zap-code-challenge
pod install
open ZapCodeChallenge.xcworkspace
```

## Estrutura do código

Na pasta `ZapCodeChallenge` se encontra o código fonte principal, separado em sub-pastas.
Na pasta `ZapCodeChallengeTests` se encontram os testes unitários.

## Executando os testes

Para executar os testes, abra o projeto no Xcode e pressione `CMD+U`.
