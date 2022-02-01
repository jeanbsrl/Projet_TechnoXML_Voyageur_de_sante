<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:med="http://www.ujf-grenoble.fr/l3miage/medical"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    <xsl:output method="html"/>
    <xsl:param name="destinedId" select="001"/>
    <xsl:variable name="visitesDuJour" select="med:cabinet/med:patients/med:patient/med:visite[@intervenant=$destinedId]"/>
    <xsl:variable name="actes" select="document('actes.xml', /)/act:ngap"/>

    <xsl:template match="/">
        <html>
            <head>
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
                <title>Visites triées</title>
            </head>
            <body>
                <p>
                    Bonjour 
                    <xsl:value-of select="med:cabinet/med:infirmiers/med:infirmier[@id=$destinedId]/med:prénom/text()"/>,
                </p>
                <h3>
                    Aujourd'hui, vous avez 
                    <xsl:value-of select="count($visitesDuJour)"/>
                    patients
                </h3>
                <h2>
                    Les patients à visiter :
                </h2>
                <xsl:apply-templates select="$visitesDuJour"/>
            
            </body>
        </html>
    </xsl:template>

    <xsl:template match="med:visite">
        <html>
            <xsl:variable name="actesDuPatient" select="med:actes"/>
            <h3>
                Nom patient :
                <xsl:value-of select="../med:nom"/>
            </h3>
            <h4>
                Son adresse :
                <xsl:value-of select="../med:adresse/med:numéro"/>
                <xsl:value-of select="../med:adresse/med:rue"/>,
                <xsl:value-of select="../med:adresse/med:codePostal"/>
                <xsl:value-of select="../med:adresse/med:ville"/>,
                étage <xsl:value-of select="../med:adresse/med:étage"/>
            </h4>
            <h4>
                <xsl:param name="acteId" select="med:acte/@id"/>
                Liste des soins à lui fournir :
                <xsl:value-of select="$acteId"/>
                <xsl:value-of select="$actes/act:actes/act:acte[@id=$acteId]"/>
            </h4>
            <a>
                <input type="button" value="Facture">
                    <xsl:attribute name="onclick">
                        openFacture('<xsl:value-of select="../med:nom"/>',
                                    '<xsl:value-of select="../med:prénom"/>',
                                    '<xsl:value-of select="med:actes"/>')
                    </xsl:attribute>
                </input>
            </a>
        </html>
    </xsl:template>
    
</xsl:stylesheet>