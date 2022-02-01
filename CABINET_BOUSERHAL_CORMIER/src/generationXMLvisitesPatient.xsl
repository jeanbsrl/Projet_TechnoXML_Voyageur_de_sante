<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
                xmlns:med="http://www.ujf-grenoble.fr/l3miage/medical"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    <xsl:output method="xml" indent="yes"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <!--Génération de l'XML des informations relatives aux visites du patient-->
            <visites>
                <xsl:element name="name">
                    <xsl:value-of select="0"/>
                </xsl:element>
                <xsl:element name="prénom">
                    <xsl:value-of select="0"/>
                </xsl:element>
                <xsl:element name="sexe">
                    <xsl:value-of select="0"/>
                </xsl:element>
                <xsl:element name="naissance">
                    <xsl:value-of select="0"/>
                </xsl:element>
                <xsl:element name="numéroSS">
                    <xsl:value-of select="0"/>
                </xsl:element>
                <xsl:element name="adresse">
                    <xsl:element name="numéro">
                        <xsl:value-of select="0"/>
                    </xsl:element>
                    <xsl:element name="rue">
                        <xsl:value-of select="0"/>
                    </xsl:element>
                    <xsl:element name="codePostal">
                        <xsl:value-of select="0"/>
                    </xsl:element>
                    <xsl:element name="ville">
                        <xsl:value-of select="0"/>
                    </xsl:element>
                    <xsl:element name="étage">
                        <xsl:value-of select="0"/>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="visite">
                    <xsl:attribute name="date"/>
                    <xsl:element name="intervenant">
                        <xsl:element name="name">
                            <xsl:value-of select="0"/>
                        </xsl:element>
                        <xsl:element name="prénom">
                            <xsl:value-of select="0"/>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="acte">
                        <xsl:value-of select="0"/>
                    </xsl:element>
                </xsl:element>    
            </visites>
    </xsl:template>

</xsl:stylesheet>
