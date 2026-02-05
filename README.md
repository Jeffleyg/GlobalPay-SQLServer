
# 💱 GlobalPayDB — Sistema de Remessas Internacionais

Projeto de banco de dados para simular um sistema de transferências financeiras entre contas com diferentes moedas, incluindo conversão cambial, validação de saldo e controle transacional.


### 🚀 Funcionalidades

- Cadastro de clientes e contas
- Suporte a múltiplas moedas
- Conversão automática de valores
- Histórico de câmbio
- Transferências entre contas
- Validação de saldo
- Controle com TRANSACTION
- Tratamento de erros (TRY/CATCH)
- Registro de transações

### 🛠️ Tecnologias

- SQL Server
- T-SQL
- Stored Procedures

## 📂 Estrutura do Banco

### 📌 Tabelas Principais

- `Clientes`
- `Contas`
- `Moedas`
- `CambioHistorico`
- `Transacoes`


## 📑 Modelo Simplificado

### Clientes
```sql
ClienteID | Nome | Email
````

### Contas

```sql
ContaID | ClienteID | MoedaID | Saldo
```

### Moedas

```sql
MoedaID | NomeMoeda | Simbolo
```

### CambioHistorico

```sql
ID | MoedaOrigem | MoedaDestino | Taxa | DataReferencia
```

### Transacoes

```sql
ID | ContaOrigemID | ContaDestinoID | ValorOriginal | ValorFinal | TaxaAplicada | Data
```

---

## ⚙️ Instalação

1️⃣ Criar o banco:

```sql
CREATE DATABASE GlobalPayDB;
```

2️⃣ Usar o banco:

```sql
USE GlobalPayDB;
```

3️⃣ Criar as tabelas (script disponível na pasta `/database`).

4️⃣ Inserir dados iniciais.

5️⃣ Criar a procedure `sp_ExecutarRemessa`.

---

## 📥 Dados Iniciais (Exemplo)

```sql
INSERT INTO Moedas VALUES
('BRL','Real Brasileiro','R$'),
('HTG','Gourde Haitiano','G'),
('USD','Dólar Americano','$');

INSERT INTO Clientes VALUES
('Jean Baptiste','jean@gmail.com'),
('Joao Silva','joao@gmail.com');

INSERT INTO Contas VALUES
(1,'HTG',5000),
(2,'BRL',1500);
```

---

## 💱 Câmbio

```sql
INSERT INTO CambioHistorico
(MoedaOrigem, MoedaDestino, Taxa)
VALUES
('BRL','HTG',12.50),
('HTG','BRL',0.040);
```

---

## 🔁 Executar Transferência

Para realizar uma remessa:

```sql
EXEC sp_ExecutarRemessa
	@ContaOrigemID = 1,
	@ContaDestinoID = 2,
	@ValorEnviar = 100;
```

---

## 📊 Consultar Saldos

```sql
SELECT * FROM Contas;
```

---

## 📜 Consultar Histórico

```sql
SELECT * FROM Transacoes;
```

---

## ⚠️ Tratamento de Erros

O sistema valida:

* Saldo insuficiente
* Taxa inexistente
* Contas inválidas

Erros são tratados via:

* TRY / CATCH
* TRANSACTION
* THROW / RAISERROR

---

## 🔒 Segurança

* Rollback automático em falhas
* Consistência garantida
* Prevenção contra transferências inválidas

---

## 📈 Próximas Melhorias

* Integração com API de câmbio
* Dashboard financeiro
* Extrato por cliente
* Controle de usuários
* Autenticação
* API REST (Java / Node.js)

---

## 👨‍💻 Autor

Jeffley Garçon
Estudante de Ciência da Computação
Projeto para estudo e prática em bancos de dados e sistemas financeiros.

---

## ⭐ Licença

Projeto educacional — uso livre para fins acadêmicos.
