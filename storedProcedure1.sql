CREATE TABLE notas (
    aluno_id INT,
    nota DECIMAL(5,2)
);


INSERT INTO notas VALUES
(1, 8.5),
(1, 7.0),
(2, 9.0);
CALL MediaNotasAluno(99); 
