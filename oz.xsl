<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="_">
		<xsl:param name="key" />
		<xsl:variable name="str" select="$STRINGS//str[@name = $key]" />
		<xsl:choose>
			<xsl:when test="$str[lang($LANGUAGE)]">
				<xsl:for-each select="$str[lang($LANGUAGE)][1]/node()">
					<xsl:copy-of select="." />
				</xsl:for-each>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$key" />
				<xsl:message>Unlocalized string: <xsl:value-of select="$key" />, language: <xsl:value-of select="$LANGUAGE" /></xsl:message>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template name="html-link">
		<xsl:param name="href" select="''" />
		<xsl:param name="value" />
		<xsl:element name="a">
			<xsl:attribute name="href">
				<xsl:if test="substring($href, 1, 1) = '/'">
					<xsl:value-of select="$BASE"/>
				</xsl:if>
				<xsl:value-of select="$href"/>
			</xsl:attribute>
			<xsl:copy-of select="$value" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template name="html-form">
		<xsl:param name="action" select="''" />
		<xsl:param name="method" />
		<xsl:param name="content" />
		<xsl:element name="form">
			<xsl:attribute name="action">
				<xsl:if test="substring($action, 1, 1) = '/'">
					<xsl:value-of select="$BASE"/>
				</xsl:if>
				<xsl:value-of select="$action"/>
			</xsl:attribute>
			
			<xsl:attribute name="method">
				<xsl:choose>
					<xsl:when test="$action = 'get'">get</xsl:when>
					<xsl:otherwise>post</xsl:otherwise>
				</xsl:choose>
			</xsl:attribute>
			
			<xsl:if test="($method != 'get') and ($method != 'post')">
				<input type="hidden" name="http_method" value="{$method}" />
			</xsl:if>

			<xsl:copy-of select="$content" />
		</xsl:element>
	</xsl:template>

	<xsl:template name="html-head">
		<xsl:param name="title" select="''" />
		<xsl:if test="$title">
			<title><xsl:value-of select="$title" /></title>
		</xsl:if>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	</xsl:template>

	<xsl:template name="indent">
		<xsl:param name="amount" />
		<xsl:if test="$amount &gt; 0">
			<xsl:text>  </xsl:text>
			<xsl:call-template name="indent">
				<xsl:with-param name="amount" select="$amount - 1" />
			</xsl:call-template>
		</xsl:if> 
	</xsl:template>
	
	<xsl:template name="xml">
		<xsl:param name="depth" select="0" />
		
		<!-- start tag name -->
		<xsl:call-template name="indent"><xsl:with-param name="amount" select="$depth" /></xsl:call-template>
		<xsl:text>&lt;</xsl:text>
		<xsl:value-of select="name()" />
		
		<!-- attributes -->
		<xsl:for-each select="@*">
			<xsl:text> </xsl:text>
			<xsl:value-of select="name()" />
			<xsl:text>="</xsl:text>
			<xsl:value-of select="." />
			<xsl:text>"</xsl:text>
		</xsl:for-each>
		
		<xsl:choose>
			<!-- empty -->
			<xsl:when test="not(node())">
				<xsl:text>/</xsl:text>
			</xsl:when>
			
			<!-- not empty -->
			<xsl:otherwise>
				<xsl:text>&gt;
</xsl:text>
		
				<!-- children -->
				<xsl:for-each select="* | text()">
					<xsl:choose>
						<!-- text content -->
						<xsl:when test="name() = ''">
							<xsl:call-template name="indent"><xsl:with-param name="amount" select="$depth + 1" /></xsl:call-template>
							<xsl:value-of select="." />
							<xsl:text>
</xsl:text>
						</xsl:when>
						
						<!-- node content -->
						<xsl:otherwise>
							<xsl:call-template name="xml">
								<xsl:with-param name="depth" select="$depth + 1" />
							</xsl:call-template>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:for-each>
		
				<!-- end tag name -->
				<xsl:call-template name="indent"><xsl:with-param name="amount" select="$depth" /></xsl:call-template>
				<xsl:text>&lt;/</xsl:text>
				<xsl:value-of select="name()" />
			</xsl:otherwise>
		</xsl:choose>
		
		<!-- end -->
		<xsl:text>&gt;
</xsl:text>
		
	</xsl:template>

</xsl:stylesheet>
