byte[] data;
String content;
HashMap<String, ArrayList> freq;
int STATE = 2;

void setup(){
  fullScreen();
  background(0);
  fill(255);
  textSize(20);
  textAlign(LEFT, TOP);

  data = loadBytes("data.txt");
  content = new String(data);

  String cleaned = content.toLowerCase().replaceAll("\n", " ").replaceAll(" +", " ");
  freq = chained(cleaned.toCharArray());

  printMap(freq);

  displayP(50, '.', 50);
}

void draw(){}

void keyPressed(){
  if(key == ' ')
    displayP(50, '.', 50);
}

void printMap(HashMap m){
  for(Object k : m.keySet())
    println(k.toString() + ":" + m.get(k).toString());
}

HashMap<String, ArrayList> chained(char[] input){
  HashMap<String, ArrayList> output = new HashMap<String, ArrayList>();

  int i = 0;
  for(String k : input){
    if(output.get(k) == null)
      output.put(k, new ArrayList());

    output.get(k).add(i + 1 == input.length ? ' ' : input[i + 1]);
    i++;
  }

  return output;
}

String gen(HashMap<Character, ArrayList> chain, char end){
  StringBuilder output = new StringBuilder(" ");

  while(output.indexOf(end) == -1){
    ArrayList<Character> cands = chain.get(output.substring());
    output.append(cands.get(int(random(cands.size()))));
  }

  return output.substring(1) + " ";
}

void display(String t, int pad){
  background(0);
  text(t, pad, pad, width - pad * 2, height - pad * 2);
}

void displayP(int i, char end, int pad){
  StringBuilder p = new StringBuilder();
  for(; i > 0; i--){
    p.append(gen(freq, '.'));
  }
  display(p.toString(), pad);
}
