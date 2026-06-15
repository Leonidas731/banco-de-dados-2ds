-- Schema SQL
CREATE TABLE Clientes (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Data_Cadastro DATE NOT NULL
);

-- Inserindo a primeira linha
INSERT INTO Clientes (Nome, Email, Data_Cadastro)
VALUES ('Ana Silva', 'ana.silva@example.com', CURDATE());

-- Query SQL
SELECT * FROM Clientes;

-- Inserindo mais linhas (2 e 3) em um único comando
INSERT INTO Clientes (Nome, Email, Data_Cadastro)
VALUES 
('Bruno Costa', 'bruno.costa@example.com', '2026-06-15'),
('Carla Souza', 'carla.souza@example.com', '2026-06-15');

-- Consultando novamente toda a tabela
SELECT * FROM Clientes;
