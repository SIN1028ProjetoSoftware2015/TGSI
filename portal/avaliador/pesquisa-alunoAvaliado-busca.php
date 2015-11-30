<?php
    //Define a p�gina como sendo do coordenador para uso restrito
    session_start();
    $_SESSION['categoriaPagina'] = 3;
    include("../restrito.php");
    include("cabecalho.php");
    include("../navbar.php");
    include("navbar_avaliador.php");
    
    include("../include/conexao.php");
    include("../include/funcoes.php"); 
    
    if (!empty($_POST)){
        $ano = $mysqli->real_escape_string($_POST['ano']);
        
        if ($ano != ''){
            $semestre  = $mysqli->real_escape_string($_POST['semestre']);
        } else {
          $semestre = 0; 
        }
        
        if (($ano != '') && ($semestre > 0)){
            $cabecalho = '- '.$semestre.'� Semestre de '.$ano;            
        } else if ($ano != ''){
            $cabecalho = '- Ano de '.$ano;  
        } else {
            $cabecalho = '- Todos';
        }
    } else {
        echo "<script>location.href='pesquisa-alunoAvaliado.php';</script>";
        $mysqli->Close();
        die();        
    }
    
    $Avaliador = $_SESSION['UsuarioCOD'];
?>
    <!-- main -->
    <div class="band">
        <div class="container">
            <h2 class="primary stroked-bottom text-shadowed margin-bottom "> Pesquisa de alunos avaliados <?php echo $cabecalho; ?></h2>
            <!--tabela-->
            <br>
            <div id="paginationWrapper"> 
                <table class="bordered rounded diced striped hovered shadowed narrow table">
                    
                    <?php
                        $sqlBusca = "SELECT b.`ban_codigo`, 
                                            b.`ban_tipo`, 
                                            b.`ban_data`, 
                                            b.`ban_descricao`, 
                                            b.`ban_local`, 
                                            b.`usu_codigo`, 
                                            b.`tur_codigo`, 
                                            b.`ban_hora`,
                                            db.`band_codigo`, 
                                            db.`ban_codigo` 

                                            FROM `banca_detalhe` as db 
                                                INNER JOIN `banca_detalhe_avaliacao` as bav
                                                    ON db.`band_codigo` = bav.`band_codigo`
                                                INNER JOIN `banca` as b
                                                    ON b.`ban_codigo` = db.`ban_codigo`

                                            WHERE db.`usu_codigo` = ".$Avaliador."
                                                AND bav.`bav_codigo` > 0";

                        if (($ano != '') && ($semestre > 0)){
                            $sqlBusca = $sqlBusca." AND b.`usu_codigo`IN (SELECT  td.`usu_aluno`
                                FROM `turma_detalhe` as td 
                                    INNER JOIN `turma` as t
                                        ON t.`tur_codigo` = td.`tur_codigo`
                                WHERE t.`tur_ano` = $ano
                                    AND t.`tur_semestre` = $semestre)";            
                        } else if ($ano != ''){
                            $sqlBusca = $sqlBusca." AND b.`usu_codigo`IN (SELECT  td.`usu_aluno`
                                FROM `turma_detalhe` as td 
                                    INNER JOIN `turma` as t
                                        ON t.`tur_codigo` = td.`tur_codigo`
                                WHERE t.`tur_ano` = $ano)";  
                        }
                        
                        $sqlBusca = $sqlBusca." ORDER BY b.`ban_data`, b.`ban_hora`, b.`ban_tipo`";                        
                        
                        $queryBusca = $mysqli->query($sqlBusca);

                        /*se quantidade de encontrada for maior que zero*/
                        if(mysqli_num_rows($queryBusca) > 0){
                            echo '<thead class="header">';
                            echo '    <tr>';
                            echo '        <th WIDTH="110">Data</th>';
                            echo '        <th WIDTH="90">Hora</th>';
                            echo '        <th WIDTH="200">Aluno</th>'; 
                            echo '        <th>Descri��o</th>'; 
                            echo '        <th>Local</th>'; 
                            echo '        <th WIDTH="100"></th>'; 
                            echo '    </tr>'; 
                            echo '</thead>';
                            
                            while ($Resultado = $queryBusca->fetch_assoc()) {
                                echo '<tbody>'; 
                                echo '    <tr data-role="tableRow" data-id="">';
                                echo '        <td WIDTH="110">'.date('d/m/Y', strtotime($Resultado['ban_data'])).'</td>';
                                echo '        <td WIDTH="90">'.$Resultado['ban_hora'].'</td>';
                                echo '        <td WIDTH="200">';
                                echo BuscaDado('usu_nome', 'usuario', 'usu_codigo = '.$Resultado['usu_codigo']);
                                echo '        </td>';
                                echo '        <td>'.$Resultado['ban_descricao'].'</td>';
                                echo '        <td>'.$Resultado['ban_local'].'</td>';
                                echo '        <td WIDTH="100';
                                echo '            <button type="button" class="btn mini primary">Visualizar</button>';
                                echo '        </td>'; 
                                echo '    </tr>';                       
                                echo '</tbody>';
                            }
                        } else {
                            echo "<div class='row'><div class='span8'><div class='box error";
                            echo "'><button type='button' class='close' data-dismiss='box'>&times;</button>Nada encontrado.";
                            echo "</div></div></div>";                           
                        } 
                    ?>
                </table> 
            </div>
            <br>
            <button class="btn left" id="voltar" name="voltar" type="button" onclick="parent.location='pesquisa-alunoAvaliado.php'"> 
            <i class="icon-arrow-left"></i> Voltar</button> 
        </div>
    </div>

<?php
	include("../rodape.php");
?>