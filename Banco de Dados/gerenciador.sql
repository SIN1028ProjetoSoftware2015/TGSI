-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 19-Out-2015 às 00:30
-- Versão do servidor: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `gerenciador`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `arquivo`
--

CREATE TABLE IF NOT EXISTS `arquivo` (
  `arq_codigo` int(11) NOT NULL AUTO_INCREMENT,
  `usu_aluno` int(11) DEFAULT NULL,
  `tur_codigo` int(11) DEFAULT NULL,
  `arq_data` date DEFAULT NULL,
  `arq_hora` time DEFAULT NULL,
  `arq_obs` varchar(5000) DEFAULT NULL,
  `arq_nome` varchar(100) DEFAULT NULL,
  `arq_situacao` char(1) DEFAULT NULL,
  `arq_tipo` char(1) DEFAULT NULL COMMENT 'pro_tipo = 1, 2, 3...Situacao = 1, 2, 3',
  PRIMARY KEY (`arq_codigo`),
  KEY `usu_aluno` (`usu_aluno`),
  KEY `tur_codigo` (`tur_codigo`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Extraindo dados da tabela `arquivo`
--

INSERT INTO `arquivo` (`arq_codigo`, `usu_aluno`, `tur_codigo`, `arq_data`, `arq_hora`, `arq_obs`, `arq_nome`, `arq_situacao`, `arq_tipo`) VALUES
(1, 1, 1, '0000-00-00', '03:29:18', '', '9d7d7f46ddd5badf8cd1b93068f5a948.pdf', 'N', '1'),
(2, 1, 1, '0000-00-00', '03:34:29', 'sccscsc', 'a7b9d61dab87c02427b7f396a58a5c81.pdf', 'N', '1'),
(3, 1, 1, '0000-00-00', '22:39:29', 'cscsc', '50f23db78cc47e0cfcde463df86a50b3.pdf', 'N', '1'),
(4, 1, 1, '2015-10-04', '22:40:21', 'fefef', 'a61658def835e9e3fb711e150d4fda19.pdf', 'N', '1');

-- --------------------------------------------------------

--
-- Estrutura da tabela `categoria`
--

CREATE TABLE IF NOT EXISTS `categoria` (
  `CAT_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `CAT_DESCRICAO` varchar(150) NOT NULL,
  PRIMARY KEY (`CAT_CODIGO`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Extraindo dados da tabela `categoria`
--

INSERT INTO `categoria` (`CAT_CODIGO`, `CAT_DESCRICAO`) VALUES
(1, 'Coordenador'),
(2, 'Professor (Orientador)'),
(3, 'Professor (Avaliador)'),
(4, 'Aluno');

-- --------------------------------------------------------

--
-- Estrutura da tabela `turma`
--

CREATE TABLE IF NOT EXISTS `turma` (
  `tur_codigo` int(11) NOT NULL,
  `tur_ano` year(4) DEFAULT NULL,
  `tur_semestre` tinyint(1) DEFAULT NULL,
  `tur_descricao` varchar(150) DEFAULT NULL,
  `tur_data_proposta` date DEFAULT NULL,
  PRIMARY KEY (`tur_codigo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `turma`
--

INSERT INTO `turma` (`tur_codigo`, `tur_ano`, `tur_semestre`, `tur_descricao`, `tur_data_proposta`) VALUES
(1, 2015, 2, 'Turma 02/2015', '2015-12-16');

-- --------------------------------------------------------

--
-- Estrutura da tabela `turma_detalhe`
--

CREATE TABLE IF NOT EXISTS `turma_detalhe` (
  `tud_codigo` int(11) NOT NULL AUTO_INCREMENT,
  `tur_codigo` int(11) NOT NULL,
  `usu_aluno` int(11) NOT NULL,
  `usu_orientador` int(11) NOT NULL,
  `usu_coorientador` int(11) NOT NULL,
  `tud_titulo` varchar(500) NOT NULL,
  PRIMARY KEY (`tud_codigo`),
  UNIQUE KEY `tur_codigo` (`tur_codigo`),
  UNIQUE KEY `usu_aluno` (`usu_aluno`),
  UNIQUE KEY `usu_orientador` (`usu_orientador`),
  UNIQUE KEY `usu_coorientador` (`usu_coorientador`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Extraindo dados da tabela `turma_detalhe`
--

INSERT INTO `turma_detalhe` (`tud_codigo`, `tur_codigo`, `usu_aluno`, `usu_orientador`, `usu_coorientador`, `tud_titulo`) VALUES
(1, 1, 1, 35, 36, 'Rastreabilidade na Indústria Alimentícia');

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario`
--

CREATE TABLE IF NOT EXISTS `usuario` (
  `USU_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `USU_LOGIN` varchar(100) NOT NULL,
  `USU_SENHA` varchar(150) NOT NULL,
  `USU_NOME` varchar(150) NOT NULL,
  `USU_EMAIL` varchar(150) NOT NULL,
  `USU_MATRICULA` varchar(100) NOT NULL,
  `USU_SITUACAO` tinyint(1) NOT NULL,
  PRIMARY KEY (`USU_CODIGO`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=45 ;

--
-- Extraindo dados da tabela `usuario`
--

INSERT INTO `usuario` (`USU_CODIGO`, `USU_LOGIN`, `USU_SENHA`, `USU_NOME`, `USU_EMAIL`, `USU_MATRICULA`, `USU_SITUACAO`) VALUES
(1, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'Administrador do Sistema', 'loja.anima.animus@gmail.com', '201221347', 0),
(35, 'aluno', 'f72eafc539768d2970925fd963a8f3b015a917c6', 'Visão Aluno', 'loja.anima.animus@gmail.com', '0000000', 0),
(36, 'loja.anima.animus@gmail.com', 'ebf683ced792b322a7d987ccd5eac90928761ebb', 'loja.anima.animus@gmail.com', 'loja.anima.animus@gmail.com', 'loja.anima.animus@gmail.com', 0),
(37, 'loja.anima.animus@gmail.com', 'ebf683ced792b322a7d987ccd5eac90928761ebb', 'loja.anima.animus@gmail.com', 'loja.anima.animus@gmail.com', 'loja.anima.animus@gmail.com', 0),
(38, 'loja.anima.animus@gmail.com', 'ebf683ced792b322a7d987ccd5eac90928761ebb', 'loja.anima.animus@gmail.com', 'loja.anima.animus@gmail.com', 'loja.anima.animus@gmail.com', 0),
(39, 'teste88', '1905973b7d78abc17b0c6b70fd111e1f92efa451', 'teste88', 'loja.anima.animus@gmail.com', 'teste88', 0),
(40, 'teste88', '1905973b7d78abc17b0c6b70fd111e1f92efa451', 'teste88', 'loja.anima.animus@gmail.com', 'teste88', 0),
(41, 'teste88', '1905973b7d78abc17b0c6b70fd111e1f92efa451', 'teste88', 'loja.anima.animus@gmail.com', 'teste88', 0),
(42, 'teste99', '8f748a9293deeadc84ca2853548c85506ac19912', 'teste99', 'loja.anima.animus@gmail.com', 'teste99', 0),
(43, 'teste99', '8f748a9293deeadc84ca2853548c85506ac19912', 'teste99', 'loja.anima.animus@gmail.com', 'teste99', 0),
(44, 'teste66', '12178c4c05e5a3d7f8aed28fe54e0bbabb418151', 'teste66', 'loja.anima.animus@gmail.com', 'teste66', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `usuario_categoria`
--

CREATE TABLE IF NOT EXISTS `usuario_categoria` (
  `USU_CODIGO` int(11) NOT NULL DEFAULT '0',
  `CAT_CODIGO` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`USU_CODIGO`,`CAT_CODIGO`),
  KEY `CAT_CODIGO` (`CAT_CODIGO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `usuario_categoria`
--

INSERT INTO `usuario_categoria` (`USU_CODIGO`, `CAT_CODIGO`) VALUES
(1, 1),
(36, 1),
(39, 1),
(42, 1),
(44, 1),
(1, 2),
(1, 3),
(1, 4),
(35, 4);

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `arquivo`
--
ALTER TABLE `arquivo`
  ADD CONSTRAINT `tur_codigo` FOREIGN KEY (`tur_codigo`) REFERENCES `turma` (`tur_codigo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `usu_aluno` FOREIGN KEY (`usu_aluno`) REFERENCES `usuario` (`USU_CODIGO`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `turma_detalhe`
--
ALTER TABLE `turma_detalhe`
  ADD CONSTRAINT `tud_tur_codigo` FOREIGN KEY (`tur_codigo`) REFERENCES `turma` (`tur_codigo`),
  ADD CONSTRAINT `tud_usu_aluno` FOREIGN KEY (`usu_aluno`) REFERENCES `usuario` (`USU_CODIGO`),
  ADD CONSTRAINT `tud_usu_coorientador` FOREIGN KEY (`usu_coorientador`) REFERENCES `usuario` (`USU_CODIGO`),
  ADD CONSTRAINT `tud_usu_orientador` FOREIGN KEY (`usu_orientador`) REFERENCES `usuario` (`USU_CODIGO`);

--
-- Limitadores para a tabela `usuario_categoria`
--
ALTER TABLE `usuario_categoria`
  ADD CONSTRAINT `usuario_categoria_ibfk_1` FOREIGN KEY (`USU_CODIGO`) REFERENCES `usuario` (`USU_CODIGO`),
  ADD CONSTRAINT `usuario_categoria_ibfk_2` FOREIGN KEY (`CAT_CODIGO`) REFERENCES `categoria` (`CAT_CODIGO`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
