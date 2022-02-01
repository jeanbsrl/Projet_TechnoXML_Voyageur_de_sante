<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : patient_html.xsl
    Created on : 16 novembre 2021, 16:12
    Author     : tom
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xml:space="">
    <xsl:output method="html" indent="yes"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="patient">
        <html>
            <head>
                <title>
                    <xsl:value-of select="nom/text()"/>, <xsl:value-of select="prénom/text()"/>
                </title>
                <link rel="stylesheet" href="../css/patientHtml.css"/>
                   
            </head>
            
            
            <body>
                <div>
                    <p class="grosTitre" >
                        Vos informations
                    </p>
                </div>
                <div>
                    <div>
                        <div>
                            <h5 class="nom">
                                <p>
                                    <span>
                                        <xsl:value-of select="nom"/>
                                    </span>, <span>
                                        <xsl:value-of select="prénom"/>
                                    </span>
                                
                                </p>
                            </h5>

                            <p class="card">
                                <u>Sexe</u> : <xsl:value-of select="sexe"/>
                                <br/>
                                <u>Date de naissance</u> : <xsl:value-of select="naissance"/>
                                <br/>
                                <u>Numéro de sécurité sociale</u> : <xsl:value-of select="numéroSS"/>
                                <br/>
                                <u>Adresse</u> : 
                                <xsl:if test="string-length(adresse/numéro/text()) &gt; 0">
                                    <xsl:value-of select="adresse/numéro"/> &#160;
                                </xsl:if> 
                                <xsl:value-of select="adresse/rue"/>, 
                                <xsl:if test="string-length(adresse/étage/text()) &gt; 0">
                                    étage <xsl:value-of select="adresse/étage"/>, 
                                </xsl:if> 
                                <xsl:value-of select="adresse/codePostal"/>&#160;
                                <xsl:value-of select="adresse/ville"/>.
                            </p>
                            <a>
                                <xsl:apply-templates select="visite">
                                    <xsl:sort select="@date"/>
                                </xsl:apply-templates>
                            </a>
                        </div>
                    </div>
                </div>
                
                
            </body>
        </html>
    </xsl:template>
            
    <xsl:template match="visite">
        <div class="card" >
            <div>
                <h5 class="date">
                    <p>
                        <xsl:value-of select="@date"/>
                    </p>
                </h5>
                <h6 class="intervenant">
                    <u>Intervenant</u> : 
                    <span>
                        <xsl:value-of select="intervenant/nom"/>
                    </span>&#160;
                    <span>
                        <xsl:value-of select="intervenant/prénom"/> 
                    </span>
                </h6>
                <p class="actes">
                    <u>Actes prévus</u> :
                    <ul>
                        <xsl:apply-templates select="acte"/>
                    </ul>
                </p>
            </div>
        </div>
    </xsl:template> 
    
    <xsl:template match="acte">
        <li>
            <xsl:value-of select="./text()"/>
        </li>
    </xsl:template>
            
            
    
</xsl:stylesheet>
