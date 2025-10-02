-- seed_bd.sql
-- Popula o banco com dados mínimos para testes.
USE appdb;

INSERT INTO tbl_moto VALUES (1, 'ABC1234', '9BWZZZ377VT004251', 'Ativa', 'Mottu Pop');
INSERT INTO tbl_moto VALUES (2, 'DEF5678', '9BWZZZ377VT004252', 'Ativa', 'Mottu E');
INSERT INTO tbl_moto VALUES (3, 'GHI9012', '9BWZZZ377VT004253', 'Manutencao', 'Mottu Pop');
INSERT INTO tbl_moto VALUES (4, 'JKL3456', '9BWZZZ377VT004254', 'Ativa', 'Mottu Sport');
INSERT INTO tbl_moto VALUES (5, 'MNO7890', '9BWZZZ377VT004255', 'Ativa', 'Mottu Pop');

INSERT INTO tbl_manutencao VALUES (1, 'Aberta', 'Troca de óleo', '2025-05-10 00:00:00', '2025-05-12 00:00:00', 3);
INSERT INTO tbl_manutencao VALUES (2, 'Fechada', 'Revisão elétrica', '2025-04-15 00:00:00', '2025-04-18 00:00:00', 2);
INSERT INTO tbl_manutencao VALUES (3, 'Fechada', 'Substituição de pneus', '2025-03-01 00:00:00', '2025-03-05 00:00:00', 1);
INSERT INTO tbl_manutencao VALUES (4, 'Aberta', 'Manutenção geral', '2025-05-01 00:00:00', '2025-05-20 00:00:00', 4);
INSERT INTO tbl_manutencao VALUES (5, 'Fechada', 'Correção de freios', '2025-04-01 00:00:00', '2025-04-03 00:00:00', 5);

INSERT INTO tbl_qrcode VALUES (1, '2025-05-20 08:00:00', 'http://mottu.com/1234.png', 1);
INSERT INTO tbl_qrcode VALUES (2, '2025-05-20 08:10:00', 'http://mottu.com/12345.png', 2);
INSERT INTO tbl_qrcode VALUES (3, '2025-05-20 08:20:00', 'http://mottu.com/123456.png', 3);
INSERT INTO tbl_qrcode VALUES (4, '2025-05-20 08:30:00', 'http://mottu.com/1234567.png', 4);
INSERT INTO tbl_qrcode VALUES (5, '2025-05-20 08:40:00', 'http://mottu.com/12345678.png', 5);

INSERT INTO tbl_sensor VALUES (1, 'Proximidade', '1', '2025-05-20 08:01:00', 1);
INSERT INTO tbl_sensor VALUES (2, 'Longe', '5', '2025-05-20 08:02:00', 2);
INSERT INTO tbl_sensor VALUES (3, 'Proximidade', '0', '2025-05-20 08:03:00', 3);
INSERT INTO tbl_sensor VALUES (4, 'Longe', '7', '2025-05-20 08:04:00', 4);
INSERT INTO tbl_sensor VALUES (5, 'Proximidade', '1', '2025-05-20 08:05:00', 5);

INSERT INTO tbl_vaga VALUES (1, 'Ocupada', '2025-05-20 07:50:00', '2025-05-20 08:50:00', 1);
INSERT INTO tbl_vaga VALUES (2, 'Livre',   '2025-05-20 07:55:00', '2025-05-20 08:10:00', 2);
INSERT INTO tbl_vaga VALUES (3, 'Ocupada', '2025-05-20 08:00:00', '2025-05-20 09:00:00', 3);
INSERT INTO tbl_vaga VALUES (4, 'Livre',   '2025-05-20 08:10:00', '2025-05-20 09:15:00', 4);
INSERT INTO tbl_vaga VALUES (5, 'Ocupada', '2025-05-20 08:20:00', '2025-05-20 09:30:00', 5);

INSERT INTO tbl_galpao VALUES (1, 'Rua A', 'Galpão Central', 100, 12345678);
INSERT INTO tbl_galpao VALUES (2, 'Rua B', 'Galpão Norte', 101, 12345675);
INSERT INTO tbl_galpao VALUES (3, 'Rua C', 'Galpão Sul', 102, 12345680);

INSERT INTO tbl_galpao_vaga VALUES (1, 1);
INSERT INTO tbl_galpao_vaga VALUES (1, 2);
INSERT INTO tbl_galpao_vaga VALUES (2, 3);
INSERT INTO tbl_galpao_vaga VALUES (3, 4);
INSERT INTO tbl_galpao_vaga VALUES (3, 5);
