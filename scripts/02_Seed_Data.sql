USE GlobalPayDB;
GO

INSERT INTO Moedas (MoedaID, NomeMoeda, Simbolo) VALUES
('BRL', 'Real Brasileiro', 'R$'),
('HTG', 'Gourde Haitiano', 'G'),
('USD', 'Dólar Americano', '$');

INSERT INTO Clientes ( Nome, Email) VALUES
('Jean Baptiste','jean@gmail.com'),
('Joao Silva','joao@gmail.com');


INSERT INTO CambioHistorico (MoedaOrigem, MoedaDestino, Taxa)
VALUES
('BRL', 'HTG', 12.50),
('HTG', 'BRL', 0.040);

GO