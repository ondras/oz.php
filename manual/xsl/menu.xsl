<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="menu">
		<ul>
			<li>
				<xsl:call-template name="html-link">
					<xsl:with-param name="value" select="'Home'" />
					<xsl:with-param name="href" select="'/'" />
				</xsl:call-template>
			</li>
			<li>
				<xsl:call-template name="html-link">
					<xsl:with-param name="value" select="'Templating'" />
					<xsl:with-param name="href" select="'/template'" />
				</xsl:call-template>
			</li>
			<li>
				Article no. 
				<xsl:call-template name="html-link">
					<xsl:with-param name="value" select="'1'" />
					<xsl:with-param name="href" select="'/article/1'" />
				</xsl:call-template>, 
				<xsl:call-template name="html-link">
					<xsl:with-param name="value" select="'2'" />
					<xsl:with-param name="href" select="'/article/2'" />
				</xsl:call-template>, 
				<xsl:call-template name="html-link">
					<xsl:with-param name="value" select="'3'" />
					<xsl:with-param name="href" select="'/article/3'" />
				</xsl:call-template>
			</li>
			<li>
				Sources: 
				<xsl:call-template name="html-link">
					<xsl:with-param name="value" select="'index.php'" />
					<xsl:with-param name="href" select="'/index.phps'" />
				</xsl:call-template>, 
				<xsl:call-template name="html-link">
					<xsl:with-param name="value" select="'Application class'" />
					<xsl:with-param name="href" select="'/manual.phps'" />
				</xsl:call-template>
			</li>
		</ul>
	</xsl:template>
</xsl:stylesheet>
