---
title: "Validador em Python"
date: 2019-05-12T18:26:43-03:00
draft: true
---

## O que você vai ver aqui: 

A ideia aqui é mostrar como criar uma lista de validadores para campos usando algumas 
das facilidades de sintaxe do python, como:

- tipos como objetos
- funções de primeira ordem
- funções lambda

## Como fazer?

Imagine que precisamos validar os dados de um objeto python simples, e temos uma lista
de regras para cada um dos campos. Isso é algo comum, e que usualmente seria implementado
como:

{{<highlight python "linenos=table">}}
for campo in objeto_dados:
    if campo == 'nome':
        if type(campo) is not str:
            raise ValueField("Nome deve ser string")
        elif campo.strip() == "":
            raise ValueField("Nome deve ser preenchido")
     # repetir para cada tipo de campo
{{</highlight>}}

O que é tedioso, e dificilmente extensível. Mas com python, podemos aproveitar
o fato de que podemos criar uma lista de validações, e iterar sobre esta
lista, com as validações que queremos efetuar.

### Parte 1: validando os campos 

No exemplo abaixo, construimos um `dict` com as validações de acordo com 
o nome do campo.

{{<highlight python "linenos=table">}}
validacoes = {
    "nome": {
        "tipo": str, 
        "validacoes": [lambda x: x.strip() != "", lambda x: len(x.strip()) > 5]
    }, 
    "idade": {
        "tipo": int, 
        "validacoes": [lambda x: 18 < x < 100]
    },
}
{{</highlight>}}

E depois montamos uma função que itera sobre a lista de campos a validar.

{{<highlight python "linenos=table,linenostart=11" >}}
def validar(dados, validacao):
    for dados_chave, dados_valor in dados.items():
        if dados_chave in validacao:
            if type(dados_valor) is not validacao[dados_chave]["tipo"]:
                return False, f"tipo de dado para {dados_chave} invalido"
            else:
                for validar in validacao[dados_chave]["validacoes"]:
                    if not validar(dados_valor):
                        return False, f"valor de dados para {dados_chave} inválido"
    return True, None
{{</highlight>}}

Explicando um pouco mais detalhadamente, definimos o dict de validação que tem o 
nome dos campos a validar, o tipo de dados, e uma lista das validações que 
serão aplicadas àquele campo.

No "tipo", informamos um tipo de dados válido no python. Como o tipo também é
um valor válido para o valor no dict, podemos usar este valor para comparar
o tipo de dados informado (linha **14**). Na hora de avaliar, o python vai fazer
algo como 

{{<highlight python >}}
if type('Maria') is str:
{{</highlight>}}

ou 

{{<highlight python >}}
if type(19) is int:
{{</highlight>}}

De acordo com o que foi informado no dict de validações, comparando o valor 
do campo de dados com o tipo de dados esperado.

Depois, na linha **17**, comparamos o valor com a lista de funções informada. 
Com isso, já sabend1o que os dados estão no formato esperado, podemos fazer as
validações com essa premissa, sem precisar converter os dados. 

Olhando para as linhas **4** e **8**, vemos que foram informadas funçöes *lambda*
como valores da lista. No python, as funções são membros de primeira ordem, o 
que faz com que elas possam ser passadas como parâmetros em funções ou, como
vemos aqui, como elementos de uma lista. Como as funções são mais simples, usamos
as expressões *lambda*, mas nada impediria de passar um nome de função definida
anteriormente. Quando pegamos cada função no iterador da linha **17**, transformamos
o `validar` na função informada, e aplicamos no valor. 