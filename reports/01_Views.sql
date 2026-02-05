USE GlobalPayDB;
GO

CREATE VIEW rel_transacoes 
AS
SELECT
	Transacoes.TransacaoID
	,Clientes.Nome AS Remetente
	,Contas.MoedaID AS MoedaOrigem
	,Transacoes.ValorOriginal
	,Transacoes.TaxaAplicada
	,cliente2.Nome AS Destinatario
	,contas2.MoedaID AS MoedaDestino
	,Transacoes.ValorFinal AS ValorRecebido
	,Transacoes.DataTransacao
FROM Transacoes
INNER JOIN Contas ON Transacoes.ContaOrigemID = Contas.ContaID
INNER JOIN Clientes ON Contas.ClienteID = Clientes.ClienteID
INNER JOIN Contas contas2 ON Transacoes.ContaDestinoID = contas2.ContaID
INNER JOIN Clientes cliente2 ON contas2.ClienteID = cliente2.ClienteID;
GO