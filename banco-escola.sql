-- Criação das tabelas para SQLite

-- Tabela de Alunos
CREATE TABLE IF NOT EXISTS alunos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    data_nascimento DATE NOT NULL,
    email TEXT UNIQUE,
    telefone TEXT,
    endereco TEXT,
    cidade TEXT,
    estado TEXT,
    cep TEXT,
    data_matricula DATE NOT NULL,
    ativo BOOLEAN DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Professores
CREATE TABLE IF NOT EXISTS professores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    email TEXT UNIQUE,
    telefone TEXT,
    especialidade TEXT,
    data_contratacao DATE NOT NULL,
    salario REAL,
    ativo BOOLEAN DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Cursos/Disciplinas
CREATE TABLE IF NOT EXISTS disciplinas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL UNIQUE,
    descricao TEXT,
    carga_horaria INTEGER NOT NULL,
    professor_id INTEGER,
    ativo BOOLEAN DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (professor_id) REFERENCES professores(id)
);

-- Tabela de Turmas
CREATE TABLE IF NOT EXISTS turmas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    disciplina_id INTEGER NOT NULL,
    professor_id INTEGER NOT NULL,
    ano_letivo INTEGER NOT NULL,
    semestre INTEGER,
    horario_inicio TIME,
    horario_fim TIME,
    sala TEXT,
    capacidade INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (disciplina_id) REFERENCES disciplinas(id),
    FOREIGN KEY (professor_id) REFERENCES professores(id)
);

-- Tabela de Matrículas
CREATE TABLE IF NOT EXISTS matriculas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    aluno_id INTEGER NOT NULL,
    turma_id INTEGER NOT NULL,
    data_matricula DATE NOT NULL,
    status TEXT DEFAULT 'ativa' CHECK(status IN ('ativa', 'trancada', 'concluida')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (turma_id) REFERENCES turmas(id),
    UNIQUE(aluno_id, turma_id)
);

-- Tabela de Notas/Avaliações
CREATE TABLE IF NOT EXISTS notas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    matricula_id INTEGER NOT NULL,
    avaliacao_numero INTEGER,
    nota REAL,
    peso REAL DEFAULT 1.0,
    data_avaliacao DATE,
    tipo_avaliacao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (matricula_id) REFERENCES matriculas(id)
);

-- Tabela de Frequência
CREATE TABLE IF NOT EXISTS frequencia (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    matricula_id INTEGER NOT NULL,
    data_aula DATE NOT NULL,
    presenca BOOLEAN DEFAULT 1,
    observacoes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (matricula_id) REFERENCES matriculas(id)
);

-- Tabela de Responsáveis/Pais
CREATE TABLE IF NOT EXISTS responsaveis (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    tipo_relacao TEXT,
    email TEXT,
    telefone TEXT,
    cpf TEXT UNIQUE,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Relacionamento entre Alunos e Responsáveis
CREATE TABLE IF NOT EXISTS aluno_responsavel (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    aluno_id INTEGER NOT NULL,
    responsavel_id INTEGER NOT NULL,
    grau_parentesco TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (responsavel_id) REFERENCES responsaveis(id),
    UNIQUE(aluno_id, responsavel_id)
);

-- Índices para melhorar performance
CREATE INDEX IF NOT EXISTS idx_alunos_email ON alunos(email);
CREATE INDEX IF NOT EXISTS idx_alunos_ativo ON alunos(ativo);
CREATE INDEX IF NOT EXISTS idx_professores_email ON professores(email);
CREATE INDEX IF NOT EXISTS idx_professores_ativo ON professores(ativo);
CREATE INDEX IF NOT EXISTS idx_turmas_ano_letivo ON turmas(ano_letivo);
CREATE INDEX IF NOT EXISTS idx_matriculas_aluno ON matriculas(aluno_id);
CREATE INDEX IF NOT EXISTS idx_matriculas_turma ON matriculas(turma_id);
CREATE INDEX IF NOT EXISTS idx_notas_matricula ON notas(matricula_id);
CREATE INDEX IF NOT EXISTS idx_frequencia_matricula ON frequencia(matricula_id);
