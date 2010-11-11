<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="head">
		<xsl:param name="title" />
		<head>
			<xsl:call-template name="html-head">
				<xsl:with-param name="title" select="$title" />
			</xsl:call-template>
			<style>
				body {
					font-family: georgia;
				}
				
				#menu {
					border-bottom: 1px solid #888;
				}
				
				#menu ul {
					margin: 0px;
					padding: 0px;
				}
				
				#menu li {
					list-style-type: none;
					float: left;
					margin: 0px;
					padding: 0px;
					margin-right: 3em;
				}
				
				#menu form {
					display: inline;
				}
				
				table {
					border-collapse: collapse;
				}
				
				table thead {
					font-weight: bold;
				}
				
				table td {
					border: 1px solid #888;
					padding: 0.3em 0.6em;
				}
			</style>
		</head>
	</xsl:template>

	<xsl:template name="menu">
		<div id="menu">
			<ul>
				<li>
					<xsl:call-template name="html-link">
						<xsl:with-param name="value" select="'Home'" />
						<xsl:with-param name="href" select="'/'" />
					</xsl:call-template>
				</li>
				<li>
					<xsl:call-template name="html-link">
						<xsl:with-param name="value" select="'Articles'" />
						<xsl:with-param name="href" select="'/articles'" />
					</xsl:call-template>
				</li>
				<li>
					<xsl:call-template name="_">
						<xsl:with-param name="key">Language</xsl:with-param>
					</xsl:call-template>:
					<xsl:call-template name="html-form">
						<xsl:with-param name="action" select="'/language'" />
						<xsl:with-param name="method" select="'post'" />
						<xsl:with-param name="content">
							<input type="submit" name="language" value="en" />
							<input type="submit" name="language" value="cs" />
						</xsl:with-param>
					</xsl:call-template>
				</li>
				<li>
					Sources: [
					<xsl:call-template name="html-link">
						<xsl:with-param name="value" select="'index'" />
						<xsl:with-param name="href" select="'/index.phps'" />
					</xsl:call-template> | 
					<xsl:call-template name="html-link">
						<xsl:with-param name="value" select="'demo'" />
						<xsl:with-param name="href" select="'/demo.phps'" />
					</xsl:call-template>
					]
				</li>
			</ul>
			<div style="clear:both"></div>
		</div>
	</xsl:template>
</xsl:stylesheet>
