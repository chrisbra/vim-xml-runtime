<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:param name="xsl:variable" select="/xsl:variable" />
  <xsl:template match="/">
    <notxsl:document>
      <xsl:variable-invalid>
        <xsl:if test="2 != 1">
          xsl:text something /xsl:text
        </xsl:if>
      </xsl:variable-invalid>
    </notxsl:document>
  </xsl:template>
</xsl:stylesheet>
