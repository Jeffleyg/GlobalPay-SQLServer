USE GlobalPayDB;
GO

CREATE OR ALTER PROCEDURE sp_ExecutarRemessa
	@ContaOrigemID INT,
	@ContaDestinoID INT,
	@ValorEnviar DECIMAL(18,2)
AS
BEGIN
	SET NOCOUNT ON
	DECLARE @MoedaOrigem CHAR(3);
	DECLARE @MoedaDestino CHAR(3);
	DECLARE @TaxaAtual DECIMAL(18,6);
	DECLARE @ValorConvertido DECIMAL(18,2);

	SELECT @MoedaOrigem = MoedaID FROM Contas WHERE ContaID = @ContaOrigemID;
	SELECT @MoedaDestino = MoedaID FROM Contas WHERE ContaID = @ContaDestinoID;

	IF (@MoedaOrigem = @MoedaDestino)
		SET @TaxaAtual = 1.0;
	ELSE
		SELECT TOP 1 @TaxaAtual = taxa
		FROM CambioHistorico
		WHERE MoedaOrigem = @MoedaOrigem AND MoedaDestino = @MoedaDestino
		ORDER BY DataReferencia DESC;

	IF (@TaxaAtual IS NULL)
	BEGIN
		RAISERROR('Erro: Taxa de cambio não encontrada para as moedas selecionadas.', 16, 1)
		RETURN;
	END

	BEGIN TRY
	BEGIN TRANSACTION;
		IF (SELECT Saldo FROM Contas WHERE ContaID = @ContaOrigemID) < @ValorEnviar
		BEGIN
			;THROW 50001, 'Saldo insuficiente na conta de origem.', 1;
		END

		SET @ValorConvertido = @ValorEnviar * @TaxaAtual;

		UPDATE Contas SET Saldo = Saldo - @ValorEnviar WHERE ContaID = @ContaOrigemID;

		UPDATE Contas SET Saldo = Saldo + @ValorConvertido WHERE ContaID = @ContaDestinoID;

		INSERT INTO Transacoes (ContaOrigemID, ContaDestinoID, ValorOriginal, ValorFinal, TaxaAplicada)
		VALUES (@ContaOrigemID, @ContaDestinoID, @ValorEnviar, @ValorConvertido, @TaxaAtual);

		COMMIT TRANSACTION;

		PRINT 'Remessa processada com sucesso!';
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION;
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
		RAISERROR(@ErrorMessage, 16, 1);
	END CATCH
END;
GO


