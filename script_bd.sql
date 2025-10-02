CREATE DATABASE IF NOT EXISTS appdb
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_0900_ai_ci;
USE appdb;

-- Drop na ordem correta para respeitar FKs
DROP TABLE IF EXISTS tbl_galpao_vaga;
DROP TABLE IF EXISTS tbl_galpao;
DROP TABLE IF EXISTS tbl_sensor;
DROP TABLE IF EXISTS tbl_vaga;
DROP TABLE IF EXISTS tbl_qrcode;
DROP TABLE IF EXISTS tbl_manutencao;
DROP TABLE IF EXISTS tbl_moto;

-- Tabela principal de motos
CREATE TABLE tbl_moto (
  id_moto INT NOT NULL COMMENT 'Identificador da moto',
  placa VARCHAR(7) NULL COMMENT 'Placa do veículo',
  chassi VARCHAR(17) NULL COMMENT 'Número do chassi',
  status VARCHAR(10) NOT NULL COMMENT 'Status da moto (ex.: Ativa, Manutencao)',
  modelo VARCHAR(30) NOT NULL COMMENT 'Modelo da moto',
  PRIMARY KEY (id_moto)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Cadastro de motos';

-- Registro de manutenções da moto
CREATE TABLE tbl_manutencao (
  id_manutencao INT NOT NULL COMMENT 'Identificador da manutenção',
  status VARCHAR(10) NOT NULL COMMENT 'Status da manutenção (Aberta/Fechada)',
  motivo VARCHAR(50) NOT NULL COMMENT 'Motivo da manutenção',
  data_entrada DATETIME NOT NULL COMMENT 'Data/hora de entrada',
  data_saida DATETIME NOT NULL COMMENT 'Data/hora de saída',
  id_moto INT NOT NULL COMMENT 'FK para tbl_moto',
  PRIMARY KEY (id_manutencao, id_moto),
  CONSTRAINT fk_manutencao_moto FOREIGN KEY (id_moto)
    REFERENCES tbl_moto(id_moto)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Manutenções das motos';

-- QR Codes relacionados à moto
CREATE TABLE tbl_qrcode (
  id_qrcode INT NOT NULL COMMENT 'Identificador do QRCode',
  data_hora DATETIME NOT NULL COMMENT 'Data/hora de geração',
  imagem_url VARCHAR(100) NOT NULL COMMENT 'URL da imagem do QRCode',
  id_moto INT NOT NULL COMMENT 'FK para tbl_moto',
  PRIMARY KEY (id_qrcode, id_moto),
  CONSTRAINT fk_qrcode_moto FOREIGN KEY (id_moto)
    REFERENCES tbl_moto(id_moto)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='QRCodes das motos';

-- Leitura de sensores ligados à moto
CREATE TABLE tbl_sensor (
  id_sensor INT NOT NULL COMMENT 'Identificador do sensor',
  tipo_sensor VARCHAR(20) NOT NULL COMMENT 'Tipo do sensor (Proximidade, etc)',
  valor_lido VARCHAR(50) NOT NULL COMMENT 'Valor medido',
  data_hora DATETIME NOT NULL COMMENT 'Timestamp da leitura',
  id_moto INT NOT NULL COMMENT 'FK para tbl_moto',
  PRIMARY KEY (id_sensor),
  CONSTRAINT fk_sensor_moto FOREIGN KEY (id_moto)
    REFERENCES tbl_moto(id_moto)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Leituras de sensores';

-- Ocupação de vagas por moto
CREATE TABLE tbl_vaga (
  id_vaga INT NOT NULL COMMENT 'Identificador da vaga',
  status VARCHAR(20) NOT NULL COMMENT 'Status da vaga (Livre/Ocupada)',
  data_entrada DATETIME NOT NULL COMMENT 'Data/hora de entrada',
  data_saida DATETIME NOT NULL COMMENT 'Data/hora de saída',
  id_moto INT NOT NULL COMMENT 'FK para tbl_moto',
  PRIMARY KEY (id_vaga),
  CONSTRAINT fk_vaga_moto FOREIGN KEY (id_moto)
    REFERENCES tbl_moto(id_moto)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Controle de vagas';

-- Cadastro de galpões
CREATE TABLE tbl_galpao (
  id_galpao INT NOT NULL COMMENT 'Identificador do galpão',
  rua VARCHAR(50) NOT NULL COMMENT 'Logradouro',
  nome VARCHAR(50) NOT NULL COMMENT 'Nome do galpão',
  numero INT NOT NULL COMMENT 'Número',
  cep INT NOT NULL COMMENT 'CEP',
  PRIMARY KEY (id_galpao)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Endereços dos galpões';

-- Relação N:N entre galpão e vaga
CREATE TABLE tbl_galpao_vaga (
  id_galpao INT NOT NULL COMMENT 'FK para tbl_galpao',
  id_vaga INT NOT NULL COMMENT 'FK para tbl_vaga',
  PRIMARY KEY (id_galpao, id_vaga),
  CONSTRAINT fk_galpao FOREIGN KEY (id_galpao)
    REFERENCES tbl_galpao(id_galpao)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT fk_vaga FOREIGN KEY (id_vaga)
    REFERENCES tbl_vaga(id_vaga)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Associação entre galpões e vagas';
