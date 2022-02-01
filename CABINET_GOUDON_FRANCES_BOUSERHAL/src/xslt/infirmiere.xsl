<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : infirmiere.xsl
    Created on : 15 novembre 2021, 15:55
    Author     : tom
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                version="1.0"
                xmlns:inf="http://voyageur-de-sante/cabinetInfirmier"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    <xsl:output method="html" indent="yes"/>
    
    <xsl:param name="destinedId" select="001"/>

    <xsl:variable name="visitesDuJour" select="//inf:patients/inf:patient/inf:visite[@intervenant=$destinedId]"/>
    <xsl:variable name="actes" select="document('./actes.xml', /)/act:ngap"/>
    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <html>
            <head>
                <title> 
                    <xsl:value-of select="inf:cabinet/inf:nom"/> 
                </title>
                <link rel="stylesheet" href="../css/cabinetInfirmierHtml.css" /> 
                <script type="text/javascript">
                    <![CDATA[
                        function openFacture(prenom, nom, actes) {
                            var width  = 500;
                            var height = 300;
                            if(window.innerWidth) {
                                var left = (window.innerWidth-width)/2;
                                var top = (window.innerHeight-height)/2;
                            }
                            else {
                                var left = (document.body.clientWidth-width)/2;
                                var top = (document.body.clientHeight-height)/2;
                            }
                            var factureWindow = window.open('','facture','menubar=yes, scrollbars=yes, top='+top+', left='+left+', width='+width+', height='+height+'');
                            factureText = "Facture pour : " + prenom + " " + nom;
                            factureWindow.document.write(factureText);
                        } 
                    ]]>
                </script>
            </head>
            <body>
                <div class="container">
                    <p class="grosTitre" >
                        <xsl:value-of select="inf:cabinet/inf:nom"/>
                    </p>
                </div>
                <div class="c1">
                    <xsl:apply-templates select="//inf:infirmier[@id=$destinedId]"/>
          
                    <xsl:apply-templates select="$visitesDuJour">
                        <xsl:sort order="descending"/>
                    </xsl:apply-templates>
                </div>
                
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="inf:infirmier">
        
        <div class="card">
            <div>
                <h5 class="bonjour">Bonjour <xsl:value-of select="inf:prénom/text()"/></h5>
                <p class="nbPatients">Aujourd'hui vous avez <xsl:value-of select="count($visitesDuJour)"/> patients.</p>
            </div>
        </div>
        
    </xsl:template>
    
    <xsl:template match="inf:visite">
        <div class="card" >
            <div class="visite">
                <h5 class="nom">
                    <span>
                        <xsl:value-of select="../inf:nom/text()"/>
                    </span>, <span>
                        <xsl:value-of select="../inf:prénom/text()"/>
                    </span>
                </h5>
                <h6 class="adresse">
                    <xsl:if test="string-length(../inf:adresse/inf:numéro/text()) &gt; 0">
                        <xsl:value-of select="../inf:adresse/inf:numéro"/>&#160;
                    </xsl:if> 
                    <xsl:value-of select="../inf:adresse/inf:rue"/>, 
                    <xsl:if test="string-length(../inf:adresse/inf:étage/text()) &gt; 0">étage <xsl:value-of select="../inf:adresse/inf:étage"/>, </xsl:if> 
                    <xsl:value-of select="../inf:adresse/inf:codePostal"/>&#160;
                    <xsl:value-of select="../inf:adresse/inf:ville"/>.                
                </h6>
                <p class="actes">
                    Actes :
                    <ul>
                        <xsl:apply-templates select="inf:acte"/>
                    </ul>
                </p>
                
                <input type="button" value="Facture">
                    <xsl:attribute name="onclick">
                        openFacture('<xsl:value-of select="../inf:prénom"/>', 
                        '<xsl:value-of select="../inf:nom"/>', 
                        '<xsl:value-of select="inf:acte"/>')
                    </xsl:attribute>
                </input>
                
            </div>
        </div>
    </xsl:template>
    
    <xsl:template match="inf:acte">
        <xsl:param name="acteId" select="@id"/>
        <li>
            <xsl:value-of select="$actes/act:actes/act:acte[@id=$acteId]"/>
        </li>
    </xsl:template>

</xsl:stylesheet>
