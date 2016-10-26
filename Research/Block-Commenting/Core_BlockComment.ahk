EMB_Core_BlockComment(mbsource){
  pair := []
  collection := []
  i := 1
  while i < len(mbsource) {
    i := regexmatch( mbsource, io)%pattern%, oMatch, %i%)
    i := i + oMatch.Len(0)
    loop, Match.Count()
    {
      pair := [Match.Pos(A_index), Match.Len(A_Index)]
      collection.push pair
      i := Match.Pos(A_index) + Match.Len(A_Index)
    }
  }
  
return mbsource
}

p_EMB_Core_BC_injectCharacter(string,char){
  return
}
