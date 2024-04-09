-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 12 fév. 2024 à 11:28
-- Version du serveur : 10.4.28-MariaDB
-- Version de PHP : 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `ecf_studi2`
--

-- --------------------------------------------------------

--
-- Structure de la table `items_table`
--

CREATE TABLE `items_table` (
  `item_id` int(11) NOT NULL,
  `libelle` text NOT NULL,
  `description` varchar(1000) NOT NULL,
  `prix` double NOT NULL,
  `categorie` varchar(100) NOT NULL,
  `image` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `items_table`
--

INSERT INTO `items_table` (`item_id`, `libelle`, `description`, `prix`, `categorie`, `image`) VALUES
(199, 'arbre', 'ceci est un arbre', 20, '[végétaux]', 'null'),
(200, 'star trooper', 'ceci est un star trooper', 1500, '[star wars]', 'null'),
(201, 'Plante', 'Ceci est une plante', 152, '[végétaux]', 'null'),
(202, 'Produit Marketing', 'Ceci est un produit marketing', 150, '[Marketing]', 'null'),
(203, 'Produit Marketing', 'Ceci est un produit markketing', 150, '[Marketing]', 'null');

-- --------------------------------------------------------

--
-- Structure de la table `panier_table`
--

CREATE TABLE `panier_table` (
  `panier_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `produit_id` int(11) NOT NULL,
  `quantité` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `panier_table`
--

INSERT INTO `panier_table` (`panier_id`, `user_id`, `produit_id`, `quantité`) VALUES
(1, 0, 200, 0),
(2, 0, 200, 1),
(3, 0, 200, 1),
(4, 0, 202, 1),
(5, 0, 200, 1),
(6, 0, 200, 4),
(7, 0, 203, 1),
(8, 0, 199, 1);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs_table`
--

CREATE TABLE `utilisateurs_table` (
  `Id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `entreprise` varchar(100) NOT NULL,
  `password` text NOT NULL,
  `prenom` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `utilisateurs_table`
--

INSERT INTO `utilisateurs_table` (`Id`, `username`, `entreprise`, `password`, `prenom`, `email`) VALUES
(1, 'Glenn123', 'STUDI', 'e2937bc859b8a7063c77aafbc03f8865', 'Glenn', 'gsilpa@proton.me'),
(6, 'Martino', 'SARLMartin', '6784641e560d38b63be39d6f2a9a16ae', 'Martin', 'martin@gmail.com'),
(7, 'Bob', 'Bobby', 'e10adc3949ba59abbe56e057f20f883e', 'Auchan', 'bobby@gmail.com'),
(8, 'Baba21', 'Baba', '9e4d3d34a6df8968ccdbd93d4252968f', 'Auchan', 'baba@gmail.com'),
(9, 'Baba21', 'Baba', '9e4d3d34a6df8968ccdbd93d4252968f', 'Auchan', 'baba@gmail.com'),
(10, 'Luc', 'Lucien', '2e6fdbc573b2975790d504991183519e', 'LucSARL', 'luc@gmail.com'),
(11, 'Juneau', 'Justine', 'b55050b2f605b7cf0d48346ff3d432d3', 'LPA', 'justine@gmail.com'),
(12, 'test1', 'Test', '098f6bcd4621d373cade4e832627b4f6', 'Testo', 'test@gmail.com'),
(13, 'Jean21', 'Jean', 'b71985397688d6f1820685dde534981b', 'JeanSARL', 'jean@gmail.com'),
(14, 'JeanJean', 'Jean', 'b71985397688d6f1820685dde534981b', 'JeanSARL', 'jeanjean@gmail.com');

-- --------------------------------------------------------

--
-- Structure de la table `vendeur_table`
--

CREATE TABLE `vendeur_table` (
  `vendeur_id` int(11) NOT NULL,
  `vendeur_name` varchar(50) NOT NULL,
  `vendeur_email` varchar(50) NOT NULL,
  `vendeur_password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `vendeur_table`
--

INSERT INTO `vendeur_table` (`vendeur_id`, `vendeur_name`, `vendeur_email`, `vendeur_password`) VALUES
(1, 'ventalis', 'ventalis@gmail.com', '123456');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `items_table`
--
ALTER TABLE `items_table`
  ADD PRIMARY KEY (`item_id`);

--
-- Index pour la table `panier_table`
--
ALTER TABLE `panier_table`
  ADD PRIMARY KEY (`panier_id`);

--
-- Index pour la table `utilisateurs_table`
--
ALTER TABLE `utilisateurs_table`
  ADD PRIMARY KEY (`Id`);

--
-- Index pour la table `vendeur_table`
--
ALTER TABLE `vendeur_table`
  ADD PRIMARY KEY (`vendeur_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `items_table`
--
ALTER TABLE `items_table`
  MODIFY `item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=204;

--
-- AUTO_INCREMENT pour la table `panier_table`
--
ALTER TABLE `panier_table`
  MODIFY `panier_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `utilisateurs_table`
--
ALTER TABLE `utilisateurs_table`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `vendeur_table`
--
ALTER TABLE `vendeur_table`
  MODIFY `vendeur_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
