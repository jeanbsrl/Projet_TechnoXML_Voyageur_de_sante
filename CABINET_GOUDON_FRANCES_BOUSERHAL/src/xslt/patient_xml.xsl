<?xml version="1.0" encoding="UTF-8"?>

<!--
    Document   : patient.xsl
    Created on : 16 novembre 2021, 11:01
    Author     : tom
    Description:
        Purpose of transformation follows.
-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                version="1.0"
                xmlns:inf="http://voyageur-de-sante/cabinetInfirmier"
                xmlns:act="http://www.ujf-grenoble.fr/l3miage/actes">
    <xsl:output method="xml" indent="yes"/>
    <xsl:param name="destinedName" select="'Pien'"/> 
    
    <xsl:variable name="actes" select="document('../xml/actes.xml', /)/act:ngap"/>
    
    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="/">
        <xsl:element name="patient">
            <xsl:apply-templates select="inf:cabinet/inf:patients/inf:patient[inf:nom=$destinedName]"/>
        </xsl:element>            
    </xsl:template>
 
            
    <xsl:template match="inf:patient">
        <xsl:element name="nom">
            <xsl:value-of select="inf:nom"/>
        </xsl:element>
        <xsl:element name="prénom">
            <xsl:value-of select="inf:prénom"/>
        </xsl:element>
        <xsl:element name="sexe">
            <xsl:value-of select="inf:sexe"/>
        </xsl:element>
        <xsl:element name="naissance">
            <xsl:value-of select="inf:naissance"/>
        </xsl:element>
        <xsl:element name="numéroSS">
            <xsl:value-of select="inf:numéro"/>
        </xsl:element>
        <xsl:apply-templates select="inf:adresse"/>
        <xsl:apply-templates select="inf:visite"/>
    </xsl:template>
    
    
    <xsl:template match="inf:adresse">
        <xsl:element name="adresse">
            <xsl:if test="string-length(inf:étage/text()) &gt; 0">
                <xsl:element name="étage">
                    <xsl:value-of select="inf:étage/text()"/>
                </xsl:element>
            </xsl:if>
            <xsl:if test="string-length(inf:numéro/text()) &gt; 0">
                <xsl:element name="numéro">
                    <xsl:value-of select="inf:numéro/text()"/>
                </xsl:element>
            </xsl:if>
            <xsl:element name="rue">
                <xsl:value-of select="inf:rue/text()"/>
            </xsl:element>
            <xsl:element name="ville">
                <xsl:value-of select="inf:ville/text()"/>
            </xsl:element>
            <xsl:element name="codePostal">
                <xsl:value-of select="inf:codePostal/text()"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="inf:visite">
        <xsl:param name="infirmiereId" select="@intervenant"/>
        <xsl:param name="acteId" select="@intervenant"/>
        <xsl:element name="visite">
            <xsl:attribute name="date">
                <xsl:value-of select="@date"/>
            </xsl:attribute>
            <xsl:element name="intervenant">
                <xsl:element name="nom"> 
                    <xsl:value-of select="../../../inf:infirmiers/inf:infirmier[@id=$infirmiereId]/inf:nom"/> 
                </xsl:element>
                <xsl:element name="prénom"> 
                    <xsl:value-of select="../../../inf:infirmiers/inf:infirmier[@id=$infirmiereId]/inf:prénom"/> 
                </xsl:element>
            </xsl:element>
            <xsl:apply-templates select="inf:acte"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="inf:acte">
        <xsl:variable name="acteId" select="@id"/>
        <xsl:element name="acte">
            <xsl:value-of select="$actes/act:actes/act:acte[@id=$acteId]/text()"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
