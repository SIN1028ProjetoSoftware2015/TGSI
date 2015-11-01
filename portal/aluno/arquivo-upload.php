<?php
include("../include/conexao.php"); 
include("../include/funcoes.php");

// Pasta onde o arquivo vai ser salvo
$_UP['pasta'] = 'uploads/';

// Tamanho m�ximo do arquivo (em Bytes)
$_UP['tamanho'] = 1024 * 1024 * 2; // 2Mb
//
// Array com as extens�es permitidas
$_UP['extensoes'] = array('pdf');

// Renomeia o arquivo? (Se true, o arquivo ser� salvo como .pdf e um nome �nico)
$_UP['renomeia'] = true;

// Array com os tipos de erros de upload do PHP
$_UP['erros'][0] = 'N�o houve erro';
$_UP['erros'][1] = 'O arquivo no upload � maior do que o limite!';
$_UP['erros'][2] = 'O arquivo ultrapassa o limite de tamanho especifiado!';
$_UP['erros'][3] = 'O upload do arquivo foi feito parcialmente.';
$_UP['erros'][4] = 'N�o foi feito o upload do arquivo.';

// Verifica se houve algum erro com o upload. Se sim, exibe a mensagem do erro
if ($_FILES['arquivo']['error'] != 0) {
  die("N�o foi poss�vel fazer o upload, erro:" . $_UP['erros'][$_FILES['arquivo']['error']]);
  exit; // Para a execu��o do script
}

// Caso script chegue a esse ponto, n�o houve erro com o upload e o PHP pode continuar
// Faz a verifica��o da extens�o do arquivo
$extensao = strtolower(end(explode('.', $_FILES['arquivo']['name'])));
if (array_search($extensao, $_UP['extensoes']) === false) {
  echo "Por favor, envie arquivos com as seguintes extens�es: pdf";
  exit;
}

// Faz a verifica��o do tamanho do arquivo
if ($_UP['tamanho'] < $_FILES['arquivo']['size']) {
  echo "O arquivo enviado � muito grande, envie arquivos de at� 2Mb.";
  exit;
}

// O arquivo passou em todas as verifica��es, hora de tentar mov�-lo para a pasta
// Primeiro verifica se deve trocar o nome do arquivo
if ($_UP['renomeia'] == true) {
  // Cria um nome baseado no UNIX TIMESTAMP atual e com extens�o .pdf
  $nome_final = md5(time()).'.pdf';
} else {
  // Mant�m o nome original do arquivo
  $nome_final = $_FILES['arquivo']['name'];
}

$upload = move_uploaded_file($_FILES['arquivo']['tmp_name'], $_UP['pasta'] . $nome_final);

session_start();
date_default_timezone_set('America/Sao_Paulo');

$aluno = $_SESSION['UsuarioCOD'];
$turma = $_SESSION['AlunoTurma'];
$data = date('Y-m-d');
$hora = date('H:i:s');
$obs  = $mysqli->real_escape_string($_POST['texto']);
$arqNome = $nome_final;
$arqSituacao = 'N'; // A - Aprovado ou N  - N�o aprovado, aqui no cadastro sempre passa N
 $arqTipo = $mysqli->real_escape_string($_POST['tipo']);

if ($upload == true) {
    // Cria uma query MySQL
    $sql = "INSERT INTO 
           `arquivo`(`usu_aluno`, `tur_codigo`, `arq_data`, `arq_hora`, `arq_obs`, `arq_nome`, `arq_situacao`, `arq_tipo`) 
             VALUES ('$aluno', '$turma','$data','$hora','$obs','$arqNome','$arqSituacao','$arqTipo')";
    
    // Executa o insert    
    //$mysqli->query($sql);
    mysqli_query($mysqli, $sql) or die(mysqli_error($mysqli));
    echo "<script>location.href='index.php?mensagem=Envio de arquivo efetuado com sucesso!';</script>";
    exit;

/*    if ($query == true) {
        // Upload efetuado com sucesso, exibe uma mensagem e um link para o arquivo
        echo "Upload efetuado com sucesso!";
        echo '<a href="' . $_UP['pasta'] . $nome_final . '">Clique aqui para acessar o arquivo</a>';
    } else {
        // N�o foi poss�vel fazer o upload, provavelmente a pasta est� incorreta
        echo "N�o foi poss�vel enviar o arquivo, tente novamente.";
    }*/
}
?>