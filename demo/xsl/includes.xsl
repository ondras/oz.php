<?xml version="1.0" ?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:include href="../../_.xsl" />

	<xsl:template name="head">
		<xsl:param name="title" />
		<head>
			<title><xsl:value-of select="$title" /></title>
			<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
					<a href="{concat($BASE, '/')}">Home</a>
				</li>
				<li>
					<a href="{concat($BASE, '/articles')}">Articles</a>
				</li>
				<li>
					<xsl:call-template name="_">
						<xsl:with-param name="key">Language</xsl:with-param>
					</xsl:call-template>:
					<form method="post" action="{concat($BASE, '/language')}">
						<input type="submit" name="language" value="en" />
						<input type="submit" name="language" value="cs" />
					</form>
				</li>
				<li>
					Sources: [
					<a href="{concat($BASE, '/index.phps')}">index</a> |
					<a href="{concat($BASE, '/demo.phps')}">demo</a>
					]
				</li>
			</ul>
			<div style="clear:both"></div>
		</div>
	</xsl:template>
</xsl:stylesheet>
