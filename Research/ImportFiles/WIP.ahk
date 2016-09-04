;String to do actions on is MBSource
MB := MBSource
sFilePaths := []
sFileVars := []


;Main Regex: Include\s+"(.*)"\s*,\s*(\w+)\s+as\s+string
pattern := "iO)" . "Include\s+"((?!.*Include).*?)"\s*,\s*(\w+)\s+as\s+string"

;What does the regex mean?
;~~~~~~~~~~~~~~~~~~~~~~~~~
;The desired match should consist of 'Include "<some characters>" , <some variable name> as string'
;The following is an illegal match 'Include "<some characters> Include" , <some variable name> as string'
;Prefix Option "i" makes the regex case insensitive.
;Prefix Option "O" makes the regex return an object.
;The following match is legal: 'Include "someImage.png", someImage as string' in 'Include "someScript.mb"Include "someImage.png", someImage as string'

;Test this regex
;~~~~~~~~~~~~~~~~~~~~~~~~~
;https://regex101.com/r/zA3tP7/1

match = RegExMatch(MB, pattern, mObj, 1)

If match <> "" {
   while match <> ""
   {
      ;Get captured strings
      sFilePaths.push(match1)
      sFileVars.push(match2)
      
      ;Remove the match from MB
      MB := ImportFiles_MidInvert(MB,match, mObj.Len()) 
      
      ;Find the next match
      match = RegExMatch(MB, pattern, mObj, match)
   }
  
  ;All 'Include "someFile", asdf as string' have been removed from MB. MB therefore contains the 'most complete' script so far
  ;Next steps, generate
  ; filepath variable declarations
  ; filedata variable declarations
  ; getFileData
  ; concatenate with MB
}





ImportFiles_MidInvert(sSrc, iStart, iLen){
  ;This function does the oppisite of mid. Instead of extracting a part of a string and returning the extracted part, in this case we are returning the part after extraction. You can imagine this as if we were replacing the string returned from mid() with null.
  ;Examples
  ;~~~~~~~~~~~~~~~~
  ;MidInvert("https://regex101.com/r/zA3tP7/1",6,11)  returns "https.com/r/zA3tP7/1"
  ;MidInvert("https://regex101.com/r/zA3tP7/1",1,8)   returns "regex101.com/r/zA3tP7/1"
  ;MidInvert("https://regex101.com/r/zA3tP7/1",30,8)  returns "1"
  
  ;If iStart is less than 1 then there is no leftPart
  if (iStart > 1){
    leftPart := subStr(sSrc,1,iStart-1)
  }
  
  ;If iStart+iLen is greater than the length of the string, there can't be a right part
  if iStart+iLen >= strlen(sSrc){
    rightPart := subStr(sSrc,iStart + iLen)
  }
  
  ;Return concatenation of the left and right parts.
  return leftPart . rightPart
}
