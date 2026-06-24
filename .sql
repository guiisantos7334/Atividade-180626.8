CREATE DATABASE sistema_estoque;
USE sistema_estoque;

CREATE TABLE produtos (
    produto_id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    quantidade_estoque INT NOT NULL
);

CREATE TABLE vendas (
    venda_id INT AUTO_INCREMENT PRIMARY KEY,
    produto_id INT,
    quantidade_vendida INT NOT NULL,
    data_venda DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (produto_id) REFERENCES produtos(produto_id)
);

INSERT INTO produtos (nome, quantidade_estoque) VALUES
('Notebook', 10),
('Smartphone', 20),
('Fone de Ouvido', 50);
DELIMITER $$
CREATE TRIGGER tr_atualiza_estoque_venda
AFTER INSERT ON vendas
FOR EACH ROW
BEGIN
    SET quantidade_estoque = quantidade_estoque - NEW.quantidade_vendida
    WHERE produto_id = NEW.produto_id;
END$$

DELIMITER ;
