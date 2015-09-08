<?php
    include("../restrito.php");
    include("cabecalho.php");
    include("../navbar.php");
    include("navbar_coordenador.php");
?>

    <!-- main --> 
    <div class="band"> 
        <div class="container"> 
            <h2 class="primary stroked-bottom text-shadowed margin-bottom ">Ficha de Acompanhamento das Orienta��es do TGSI</h2>
            
            <form id="formRelatorio" action="" method="post"> 
                <div class="row"> 
                    <div class="span2"> 
                        <label class="label" for="ano">Ano<span class="required"></span></label>
                        <br >
                        <input id="ano" name="ano" class="textfield width-100 integer" type="text" value=""/>  
                    </div> 
                    <div class="span3"> 
                        <span class="label">Per�odo<span class="required"></span></span>
                    <br >
                    <select id="periodo" name="periodo" class="textfield width-100"> 
                        <option value="101">1. Semestre</option>
                        <option value="102">2. Semestre</option>
                    </select>
                    </div> 
                </div>
               
                
                <div class="form-actions bottom ">            
                    <button class="btn primary gerarBtn" id="gerar" name="gerar" type="button">
                        <i class="icon-save"></i> Gerar relat�rio
                    </button>
                </div>
                <br>
            </form>
        </div>
    </div>
<?php include("../rodape.php"); ?>
