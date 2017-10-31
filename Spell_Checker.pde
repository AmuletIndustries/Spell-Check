HashEntry[] map;
ArrayList<String> overflow = new ArrayList<String>();


void setup(){
  map = new HashEntry[120000];
  Hash();
}

void Hash(){
 String[] word_dictionary = new String[120000];
 word_dictionary = loadStrings("AP CS PS03 Spell Checker - words.txt");
 for(int  i=0;i<word_dictionary.length;i++){
  HashEntry Entry=new HashEntry(word_dictionary[i],-1);
  int tableValue=MakeHash(word_dictionary[i]);
  if(map[tableValue] == null){
    map[tableValue]= Entry;
  }else{
    overflow.add(map[tableValue].Key);
    Entry.pointer=overflow.size();
    map[tableValue]=Entry;
  }
 }
}

int MakeHash(String x){
 return(abs(x.hashCode()% 120000));
}
