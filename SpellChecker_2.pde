String[] lines;
String[] words; //words in file to be checked
String delimiters = " ,.?!;:[]-()'";
int size = 130000;
HashEntry[] map;
ArrayList<String> overflow = new ArrayList<String>();
ArrayList<String> misspelled = new ArrayList<String>();



void setup() {
  size(400,400);
  background(255);
  map = new HashEntry[size];
  Hash();
  selectInput("Select a file to process:", "fileSelected");
}

void draw(){  
}

void fileSelected(File selection) { //selects the file
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    lines = loadStrings(selection.getAbsolutePath());
    String everything = join(lines, "" );
    words = splitTokens(everything, delimiters); 
    for(int i = 0; i < words.length; i++){ 
      words[i] = words[i].toLowerCase();
    }
    //printArray(words);
    checkSpelling();
  }
}

void Hash(){
  String[] word_dictionary = loadStrings("checkerwords.txt");
  for(int i = 0; i < word_dictionary.length; i++){
    word_dictionary[i].toLowerCase();
    HashEntry Entry=new HashEntry(word_dictionary[i],-1);
    int tableValue=MakeHash(word_dictionary[i]);
    if(map[tableValue] == null){
      map[tableValue]= Entry;
    }
    else{
      overflow.add(map[tableValue].Key);
      Entry.pointer=overflow.size();
      map[tableValue]=Entry;
    }
  }
}

int MakeHash(String x){
 return(abs(x.hashCode()% size));
}

void checkSpelling(){
  for(int i = 0; i < words.length; i++){
    int hash_ = MakeHash(words[i]); 
    if((map[hash_].Key).equals(words[i])){
    }
    else{
      if(map[hash_].pointer == -1){
        misspelled.add(words[i]);
      }
      else if(overflow.get(map[hash_].pointer) != words[i]){
        misspelled.add(words[i]);
      }
    }
  }
  println(misspelled);
}