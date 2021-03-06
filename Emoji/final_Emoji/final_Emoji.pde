import ketai.ui.*;
import android.view.MotionEvent;
import android.view.inputmethod.InputMethodManager;
import android.content.Context;
import java.util.*;

enum Mode 
{
  START, 
    STOP_POSTURE, 
    MOTION_POSTURE, 
    ADD_MOTION_EXPRESSION, 
    SECOND_MOTION, 
    MOTION_CHECKING, 
    ADD_EXPRESSION, 
    ADD_TEXT, 
    ADD_TEXT_MOTION,
    SAVE,
    SAVE_MOTION
};

Emoji emoji;
PFont inter_font;
PFont text_font;
KetaiGesture gesture;

void setup() {
  fullScreen(P2D);
  gesture = new KetaiGesture(this);
  emoji = new Emoji();
  inter_font = loadFont("HelveticaNeue-100.vlw");
  text_font = loadFont("_Daisy_s_Delights__-100.vlw");
}

void draw() {
  background(0);
  emoji.start();
}

void mousePressed() {
  emoji.mousePressed();
}

void mouseDragged() {
  emoji.mouseDragged();
}

void mouseReleased() {
  emoji.mouseReleased();
}

void keyPressed () {
  emoji.keyPressed();
}

class Emoji {
  protected Mode mode;
  RectButton stopButton;
  RectButton motionButton;
  RectButton saveButton;
  ArrowButton arrowButton;
  eDisplay eDisplay;
  cStorage cStorage;
  Shadow shadowB;
  Shadow shadowCS;
  CharacterFactory characterFactory;
  ArrayList<Character> allCharacters;
  ExpressionFactory expressionFactory;
  ArrayList<Expression> allExpressions;
  EmoticonFactory emoticonFactory;
  ArrayList<Emoticon> allEmoticons;
  ArrayList<Emoticon> emoticonsDraw;
  Text emoticonText;
  PImage mask;
  PGraphics pg;
  ArrayList<Emoticon> startEmoticonsDraw;
  ArrayList<Emoticon> endEmoticonsDraw;
  Animation ani;

  Emoji() {
    mode = Mode.START;
    stopButton = new RectButton(width/2, 1*9*height/10/3+height/10, int(width/2), width/9, color(232, 110, 107), "Stop Emoticon");
    motionButton = new RectButton(width/2, 2*9*height/10/3+height/10, int(width/2), width/9, color(232, 110, 107), "Motion Emoticon");
    saveButton = new RectButton(width/2, 2*9*height/10/3+height/10, int(width/2), width/9, color(232, 110, 107), "Save");
    arrowButton = new ArrowButton(9*width/10, height/20, height/30, height/15);
    eDisplay = new eDisplay(width/2, 13*height/40, width, height);
    cStorage = new cStorage();
    shadowB = new Shadow(0, height/10, width, height/100, color(0, 51), color(0, 0), 1);
    shadowCS = new Shadow(0, 11*height/20, width, height/100, color(0, 51), color(0, 0), 1);
    characterFactory = new CharacterFactory();
    characterFactory.loadXMLfile("characters.xml");
    allCharacters = characterFactory.getCharacters();
    expressionFactory = new ExpressionFactory();
    expressionFactory.loadXMLfile("expressions.xml");
    allExpressions = expressionFactory.getExpressions();
    emoticonFactory = new EmoticonFactory();
    emoticonFactory.loadXMLfile("emoticons.xml");
    allEmoticons = emoticonFactory.getEmoticons();
    emoticonsDraw = new ArrayList<Emoticon>();
    emoticonText = new Text();
    mask = loadImage("mask.png");
    pg = createGraphics(width, height, P2D);
    startEmoticonsDraw = new ArrayList<Emoticon>();
    endEmoticonsDraw = new ArrayList<Emoticon>();
    ani = new Animation(startEmoticonsDraw, endEmoticonsDraw);
    ani.start();
  }
  
  void start() {
    //background
    noStroke();
    rectMode(CORNER);
    fill(224, 139, 118);
    rect(0, 0, width, height);

    switch (mode) {
    case START:
      stopButton.draw();
      motionButton.draw();
      break;
    case STOP_POSTURE:
      //emoticon display
      eDisplay.draw(); 

      //emoticon display
      if (emoticonsDraw != null) {
        for (Emoticon e : emoticonsDraw) {
          e.draw();
        }
      } 

      imageMode(CENTER);
      image(mask, width/2, height/2, width, height);

      //character storage display
      cStorage.draw();

      //shadow on cStorage
      shadowCS.draw();

      //character display
      if (allCharacters != null) {
        for (Character c : allCharacters) {
          c.draw();
        }
      }
      break;
    case MOTION_POSTURE:
      //emoticon display
      eDisplay.draw(); 

      //emoticon display
      if (emoticonsDraw != null) {
        for (Emoticon e : emoticonsDraw) {
          e.draw();
        }
      }

      imageMode(CENTER);
      image(mask, width/2, height/2, width, height);

      //character storage display
      cStorage.draw();

      //shadow on cStorage
      shadowCS.draw();

      //character display
      if (allCharacters != null) {
        for (Character c : allCharacters) {
          c.draw();
        }
      }
      break;
    case ADD_MOTION_EXPRESSION:
      //emoticon display
      eDisplay.draw(); 

      //emoticon display
      if (emoticonsDraw != null) {
        for (Emoticon e : emoticonsDraw) {
          e.draw();
          if (e.getExpImg() != null) {
            e.drawExpression();
          }
        }
      }

      imageMode(CENTER);
      image(mask, width/2, height/2, width, height);

      //character storage display
      cStorage.draw();

      //shadow on cStorage
      shadowCS.draw();

      //character display
      if (allExpressions != null) {
        for (Expression ex : allExpressions) {
          ex.draw();
        }
      }
      break;
    case SECOND_MOTION:
      //emoticon display
      eDisplay.draw(); 

      if (emoticonsDraw != null) {
        for (Emoticon e : emoticonsDraw) {
          e.draw();
          if (e.getExpImg() != null) {
            e.drawExpression();
          }
        }
      } 

      imageMode(CENTER);
      image(mask, width/2, height/2, width, height);

      break;
    case MOTION_CHECKING:
      //emoticon display
      eDisplay.draw();

      ani.draw();

      imageMode(CENTER);
      image(mask, width/2, height/2, width, height);
      break;
    case ADD_EXPRESSION:
      //emoticon display
      eDisplay.draw(); 

      //emoticon display
      if (emoticonsDraw != null) {
        for (Emoticon e : emoticonsDraw) {
          e.draw();
          if (e.getExpImg() != null) {
            e.drawExpression();
          }
        }
      }

      imageMode(CENTER);
      image(mask, width/2, height/2, width, height);

      //character storage display
      cStorage.draw();

      //shadow on cStorage
      shadowCS.draw();

      //character display
      if (allExpressions != null) {
        for (Expression ex : allExpressions) {
          ex.draw();
        }
      }
      break;
    case ADD_TEXT:
      //emoticon display
      eDisplay.draw(); 

      //emoticon display
      if (emoticonsDraw != null) {
        for (Emoticon e : emoticonsDraw) {
          e.draw();
          if (e.getExpImg() != null) {
            e.drawExpression();
          }
        }
      }

      if (emoticonText != null && emoticonText.getText().length()>0) {
        emoticonText.drawText();
      }

      imageMode(CENTER);
      image(mask, width/2, height/2, width, height);
      break;
    case ADD_TEXT_MOTION:
      //emoticon display
      eDisplay.draw(); 

      //emoticon display
      if (emoticonsDraw != null) {
        for (Emoticon e : emoticonsDraw) {
          e.draw();
          if (e.expImg != null) {
            e.drawExpression();
          }
        }
      }

      if (emoticonText != null && emoticonText.getText().length()>0) {
        emoticonText.drawText();
      }

      imageMode(CENTER);
      image(mask, width/2, height/2, width, height);
      break;
    case SAVE:
      //emoticon display
      pg.beginDraw();
      eDisplay.pgDraw(pg); 
      if (emoticonsDraw != null) {
        for (Emoticon e : emoticonsDraw) {
          e.pgDraw(pg);
          if (e.getExpImg() != null) {
            e.pgDrawExpression(pg);
          }
        }
      }

      if (emoticonText != null && emoticonText.getText().length()>0) {
        emoticonText.pgDrawText(pg);
      }
      pg.endDraw();

      imageMode(CENTER);
      image(pg, width/2, height/2);

      imageMode(CENTER);
      image(mask, width/2, height/2, width, height);
      break;
    case  SAVE_MOTION:
      //emoticon display
      eDisplay.draw();

      ani.draw();
      
      if (emoticonText != null && emoticonText.getText().length()>0) {
        emoticonText.drawText();
      }

      imageMode(CENTER);
      image(mask, width/2, height/2, width, height);

      break;
    default:
      break;
    }

    //status bar
    rectMode(CORNER);
    noStroke();
    fill(240, 114, 168);
    rect(0, 0, width, height/10);

    //emoji text in status bar
    textAlign(CENTER, CENTER);
    textFont(inter_font, height/20);
    fill(255);
    text("EMOJI", width/2, height/20);

    if (emoticonsDraw.size() != 0 && mode != Mode.SAVE && mode != Mode.SAVE) {
      arrowButton.draw();
    }

    if (mode == Mode.SAVE || mode == Mode.SAVE_MOTION) {
      saveButton.draw();
    }

    //shadow under status bar
    shadowB.draw();
  }

  void mousePressed() {
    switch (mode) {
    case START:
      if (stopButton.isOver(mouseX, mouseY)) {
        mode = Mode.STOP_POSTURE;
      } else if (motionButton.isOver(mouseX, mouseY)) {
        mode = Mode.MOTION_POSTURE;
      }
      break;
    case STOP_POSTURE:
      for (Emoticon e : emoticonsDraw) {
        for (int i = 0; i<4; i++) {
          if (eDisplay.isOver(mouseX, mouseY)) {
            if (e.isOver(mouseX, mouseY)) {
              e.setTransPivotPos(new PVector(mouseX, mouseY));
              e.setIsTrans(true);
            }
            if (e.isOverPivot(mouseX, mouseY, i)) {
              e.setManiPivotPos(new PVector(mouseX, mouseY));
              e.setIsMani(i,true);
              e.setIsTrans(false);
              break;
            }
          }
        }
      }
      if (arrowButton.isOver(mouseX, mouseY) && emoticonsDraw.size() != 0) {
        mode = Mode.ADD_EXPRESSION;
      }
      break;
    case MOTION_POSTURE:
      for (Emoticon e : emoticonsDraw) {
        for (int i = 0; i<4; i++) {
          if (eDisplay.isOver(mouseX, mouseY)) {
            if (e.isOver(mouseX, mouseY)) {
              e.setTransPivotPos(new PVector(mouseX, mouseY));
              e.setIsTrans(true);
            }
            if (e.isOverPivot(mouseX, mouseY, i)) {
              e.setManiPivotPos(new PVector(mouseX, mouseY));
              e.setIsMani(i, true);
              e.setIsTrans(false);
              break;
            }
          }
        }
      }
      if (arrowButton.isOver(mouseX, mouseY) && emoticonsDraw.size() != 0) {
        mode = Mode.ADD_MOTION_EXPRESSION;
      }
      break;
    case ADD_MOTION_EXPRESSION:
      int exp_count = 0;
      int e_count = 0;
      for (Emoticon e : emoticonsDraw) {
        if (eDisplay.isOver(mouseX, mouseY)) {
          if (e.isOver(mouseX, mouseY)) {
            e.setTransPivotPos(new PVector(mouseX, mouseY));
            e.setIsTrans(true);
          }
        }
        e_count++;
        if (e.getExpImg() != null) {
          exp_count++;
        }
      }
      if (arrowButton.isOver(mouseX, mouseY) && e_count == exp_count) {
        for (Emoticon e : emoticonsDraw) {
          startEmoticonsDraw.add(new Emoticon(e));
        }
        mode = Mode.SECOND_MOTION;
      }
      break;
    case SECOND_MOTION:
      for (Emoticon e : emoticonsDraw) {
        for (int i = 0; i<4; i++) {
          if (eDisplay.isOver(mouseX, mouseY)) {
            if (e.isOver(mouseX, mouseY)) {
              e.setTransPivotPos(new PVector(mouseX, mouseY));
              e.setIsTrans(true);
            }
            if (e.isOverPivot(mouseX, mouseY, i)) {
              e.setManiPivotPos(new PVector(mouseX, mouseY));
              e.setIsMani(i,true);
              e.setIsTrans(false);
              break;
            }
          }
        }
      }
      if (arrowButton.isOver(mouseX, mouseY) && emoticonsDraw.size() != 0) {
        for (Emoticon e : emoticonsDraw) {
          endEmoticonsDraw.add(new Emoticon(e));
        }
        mode = Mode.MOTION_CHECKING;
      }
      break;
    case MOTION_CHECKING:
      if (arrowButton.isOver(mouseX, mouseY)) {
        mode = Mode.ADD_TEXT_MOTION;
      }
      break;
    case ADD_EXPRESSION:
      exp_count = 0;
      e_count = 0;
      for (Emoticon e : emoticonsDraw) {
        if (eDisplay.isOver(mouseX, mouseY)) {
          if (e.isOver(mouseX, mouseY)) {
            e.setTransPivotPos(new PVector(mouseX, mouseY));
            e.setIsTrans(true);
          }
        }
        e_count++;
        if (e.getExpImg() != null) {
          exp_count++;
        }
      }
      if (arrowButton.isOver(mouseX, mouseY) && e_count == exp_count) {
        mode = Mode.ADD_TEXT;
      }
      break;
    case ADD_TEXT:
      for (Emoticon e : emoticonsDraw) {
        if (eDisplay.isOver(mouseX, mouseY)) {
          if (e.isOver(mouseX, mouseY)) {
            e.setTransPivotPos(new PVector(mouseX, mouseY));
            e.setIsTrans(true);
          }
        }
      }
      if (eDisplay.isOver(mouseX, mouseY) && !emoticonText.isOver(mouseX, mouseY)) {  
        int isEmoticonSelected = 0;
        for (Emoticon e : emoticonsDraw) {
          if (e.getIsTrans()) {
            isEmoticonSelected++;
          }
        }
        if (isEmoticonSelected == 0) {
          showVirtualKeyboard();
        }
      }
      if (emoticonText.text.length() == 0) {
        emoticonText.setTextPos(mouseX, mouseY);
      }

      if (emoticonText.isOver(mouseX, mouseY)) {
        emoticonText.setIsTrans(true);
      }

      if (arrowButton.isOver(mouseX, mouseY)) {
        mode = Mode.SAVE;
      }
      break;
    case ADD_TEXT_MOTION:

      if (eDisplay.isOver(mouseX, mouseY) && !emoticonText.isOver(mouseX, mouseY)) {  
          showVirtualKeyboard();
      }
      
      if (emoticonText.text.length() == 0) {
        emoticonText.setTextPos(mouseX, mouseY);
      }

      if (emoticonText.isOver(mouseX, mouseY)) {
        emoticonText.setIsTrans(true);
      }

      if (arrowButton.isOver(mouseX, mouseY)) {
        mode = Mode.SAVE_MOTION;
      }
      break;
    case SAVE:
      if (saveButton.isOver(mouseX, mouseY)) {
        pg.save("/sdcard/DCIM/Camera/emoticon.png");
        mode = Mode.START;
        reset();
      }
      break;
    case SAVE_MOTION:
      if (saveButton.isOver(mouseX, mouseY)) {
        mode = Mode.START;
        reset();
      }
      break;
    default:
      break;
    }
  }

  void mouseDragged() {
    switch (mode) {
    case START:
      break;
    case STOP_POSTURE:
      if (allCharacters == null) return;
      for (Character c : allCharacters) {
        if (c.isOver(mouseX, mouseY)) {
          c.setPos(mouseX, mouseY);
          if (eDisplay.isOver(mouseX, mouseY))
          {
            Emoticon emoticon = null;
            for (Emoticon e : allEmoticons) {
              if (e.getName().equals(c.getName())) {
                emoticon = e;
              }
            }
            if (emoticon != null) {
              Emoticon check = null;
              for (Emoticon e : emoticonsDraw) {
                if (emoticon.getName().equals(e.getName())) {
                  check = e;
                }
              }
              if (check == null) {
                emoticonsDraw.add(emoticon);
              }
            }
          }
          return;
        }
      }
      for (Emoticon e : emoticonsDraw) {
        for (int i= 0; i<4; i++) {
          if (e.getIsMani(i)) {
            e.manipulate(mouseX, mouseY, i);
            return;
          }
          if (eDisplay.isOver(mouseX, mouseY)) {
            if (e.getIsTrans()) {
              e.translate(mouseX, mouseY);
              e.setTransPivotPos(new PVector(mouseX, mouseY));
              return;
            }
          }
        }
      }
      break;
    case MOTION_POSTURE:
      if (allCharacters == null) return;
      for (Character c : allCharacters) {
        if (c.isOver(mouseX, mouseY)) {
          c.setPos(mouseX,mouseY);
          if (eDisplay.isOver(mouseX, mouseY))
          {
            Emoticon emoticon = null;
            for (Emoticon e : allEmoticons) {
              if (e.getName().equals(c.getName())) {
                emoticon = e;
              }
            }
            if (emoticon != null) {
              Emoticon check = null;
              for (Emoticon e : emoticonsDraw) {
                if (emoticon.getName().equals(e.getName())) {
                  check = e;
                }
              }
              if (check == null) {
                emoticonsDraw.add(emoticon);
              }
            }
          }
          return;
        }
      }
      for (Emoticon e : emoticonsDraw) {
        for (int i= 0; i<4; i++) {
          if (e.getIsMani(i)) {
            e.manipulate(mouseX, mouseY, i);
            return;
          }
          if (eDisplay.isOver(mouseX, mouseY)) {
            if (e.getIsTrans()) {
              e.translate(mouseX, mouseY);
              e.setTransPivotPos(new PVector(mouseX, mouseY));
              return;
            }
          }
        }
      }
      break;
    case ADD_MOTION_EXPRESSION:
      if (allExpressions == null) return;
      for (Expression ex : allExpressions) {
        if (ex.isOver(mouseX, mouseY)) {
          ex.setPos(mouseX, mouseY);
          for (Emoticon e : emoticonsDraw) {
            if (e.isOver(mouseX, mouseY)) {
              e.setExpression(ex.filename);
            }
          }
          return;
        }
      }
      for (Emoticon e : emoticonsDraw) {
        for (int i= 0; i<4; i++) {
          if (eDisplay.isOver(mouseX, mouseY)) {
            if (e.getIsTrans()) {
              e.translate(mouseX, mouseY);
              e.setTransPivotPos(new PVector(mouseX, mouseY));
              return;
            }
          }
        }
      }
      break;
    case SECOND_MOTION:
      for (Emoticon e : emoticonsDraw) {
        for (int i= 0; i<4; i++) {
          if (e.isMani[i]) {
            e.manipulate(mouseX, mouseY, i);
            return;
          }
          if (eDisplay.isOver(mouseX, mouseY)) {
            if (e.getIsTrans()) {
              e.translate(mouseX, mouseY);
              e.setTransPivotPos(new PVector(mouseX, mouseY));
              return;
            }
          }
        }
      }
      break;
    case MOTION_CHECKING:
      break;
    case ADD_EXPRESSION:
      if (allExpressions == null) return;
      for (Expression ex : allExpressions) {
        if (ex.isOver(mouseX, mouseY)) {
          ex.setPos(mouseX, mouseY);
          for (Emoticon e : emoticonsDraw) {
            if (e.isOver(mouseX, mouseY)) {
              e.setExpression(ex.filename);
            }
          }
          return;
        }
      }
      for (Emoticon e : emoticonsDraw) {
        for (int i= 0; i<4; i++) {
          if (eDisplay.isOver(mouseX, mouseY)) {
            if (e.getIsTrans()) {
              e.translate(mouseX, mouseY);
              e.setTransPivotPos(new PVector(mouseX, mouseY));
              return;
            }
          }
        }
      }
      break;
    case ADD_TEXT:
      if (emoticonText.isOver(mouseX, mouseY) && emoticonText.getIsTrans()) {
        emoticonText.setTextPos(mouseX, mouseY);
        return;
      }
      for (Emoticon e : emoticonsDraw) {
        for (int i= 0; i<4; i++) {
          if (eDisplay.isOver(mouseX, mouseY)) {
            if (e.getIsTrans()) {
              e.translate(mouseX, mouseY);
              e.setTransPivotPos(new PVector(mouseX, mouseY));
              return;
            }
          }
        }
      }
      break;
    case ADD_TEXT_MOTION:
      if (emoticonText.isOver(mouseX, mouseY) && emoticonText.getIsTrans()) {
        emoticonText.setTextPos(mouseX, mouseY);
      }
      break;
    case SAVE:
      break;
    case  SAVE_MOTION:
      break;
    default:
      break;
    }
  }

  void mouseReleased() {
    switch (mode) {
    case START:
      break;
    case STOP_POSTURE:
      if (allCharacters == null) return;
      for (Character c : allCharacters) {
        c.setPos(c.getInitX(), c.getInitY());
      }
      for (Emoticon e : emoticonsDraw) {
        for (int i = 0; i<4; i++) {
          e.setIsMani(i,false);
        }
        e.setIsTrans(false);
      }
      break;
    case MOTION_POSTURE:
      if (allCharacters == null) return;
      for (Character c : allCharacters) {
        c.setPos(c.getInitX(), c.getInitY());
      }
      for (Emoticon e : emoticonsDraw) {
        for (int i = 0; i<4; i++) {
          e.setIsMani(i, false);
        }
        e.setIsTrans(false);
      }
      break;
    case ADD_MOTION_EXPRESSION:
      if (allExpressions == null) return;
      for (Expression ex : allExpressions) {
        ex.setPos(ex.getInitX(), ex.getInitY());
      }
      for (Emoticon e : emoticonsDraw) {
        e.setIsTrans(false);
      }
      break;
    case SECOND_MOTION:
      for (Emoticon e : emoticonsDraw) {
        for (int i = 0; i<4; i++) {
          e.setIsMani(i, false);
        }
        e.setIsTrans(false);
      }
      break;
    case MOTION_CHECKING:
      break;
    case ADD_EXPRESSION:
      if (allExpressions == null) return;
      for (Expression ex : allExpressions) {
        ex.setPos(ex.getInitX(), ex.getInitY());
      }
      for (Emoticon e : emoticonsDraw) {
        e.setIsTrans(false);
      }
      break;
    case ADD_TEXT:
      for (Emoticon e : emoticonsDraw) {
        e.setIsTrans(false);
      }
      emoticonText.setIsTrans(false);
      break;
    case SAVE:
      break;
    case  SAVE_MOTION:
      break;
    default:
      break;
    }
  }

  void keyPressed() {
    if (mode == Mode.ADD_TEXT || mode == Mode.ADD_TEXT_MOTION) {
      if (key == ENTER || key == RETURN) {
        hideVirtualKeyboard();
      } else if ((int) key == 65535 && keyCode == 67) {
        if (emoticonText.getText().length()>1) {
          emoticonText.setText(emoticonText.getText().substring(0, emoticonText.getText().length()-1));
        } else {
          emoticonText.setText("");
        }
      } else {
        emoticonText.setText(emoticonText.getText()+key);
      }
    } else {
      hideVirtualKeyboard();
    }
  }

  void reset () {
    mode = Mode.START;
    stopButton = new RectButton(width/2, 1*9*height/10/3+height/10, int(width/2), width/9, color(232, 110, 107), "Stop Emoticon");
    motionButton = new RectButton(width/2, 2*9*height/10/3+height/10, int(width/2), width/9, color(232, 110, 107), "Motion Emoticon");
    saveButton = new RectButton(width/2, 2*9*height/10/3+height/10, int(width/2), width/9, color(232, 110, 107), "Save");
    arrowButton = new ArrowButton(9*width/10, height/20, height/30, height/15);
    eDisplay = new eDisplay(width/2, 13*height/40, width, height);
    cStorage = new cStorage();
    shadowB = new Shadow(0, height/10, width, height/100, color(0, 51), color(0, 0), 1);
    shadowCS = new Shadow(0, 11*height/20, width, height/100, color(0, 51), color(0, 0), 1);
    characterFactory = new CharacterFactory();
    characterFactory.loadXMLfile("characters.xml");
    allCharacters = characterFactory.getCharacters();
    expressionFactory = new ExpressionFactory();
    expressionFactory.loadXMLfile("expressions.xml");
    allExpressions = expressionFactory.getExpressions();
    emoticonFactory = new EmoticonFactory();
    emoticonFactory.loadXMLfile("emoticons.xml");
    allEmoticons = emoticonFactory.getEmoticons();
    emoticonsDraw = new ArrayList<Emoticon>();
    emoticonText = new Text();
    mask = loadImage("mask.png");
    pg = createGraphics(width, height, P2D);
    startEmoticonsDraw = new ArrayList<Emoticon>();
    endEmoticonsDraw = new ArrayList<Emoticon>();
    ani = new Animation(startEmoticonsDraw, endEmoticonsDraw);
  }
}

class Animation extends Thread {
  ArrayList<Emoticon> startEmoticonsDraw, endEmoticonsDraw;
  int totalFrame;
  int frame;
  int flow;
  ArrayList<Emoticon> resultEmoticons;
  ArrayList<Emoticon> tempEmoticons;


  Animation (ArrayList<Emoticon> startEmoticonsDraw, ArrayList<Emoticon> endEmoticonsDraw) {
    this.startEmoticonsDraw = startEmoticonsDraw;
    this.endEmoticonsDraw = endEmoticonsDraw;
    totalFrame = 10;
    frame = 1;
    flow = 1;
    resultEmoticons = startEmoticonsDraw;
  }

  void draw() {
    for (Emoticon e : resultEmoticons) {
      e.draw();
      e.drawExpression();
    }
  }

  void animate() {
    tempEmoticons = new ArrayList<Emoticon>();
    
    for (int i =0; i<startEmoticonsDraw.size(); i++) {
      Emoticon e1 = startEmoticonsDraw.get(i);
      Emoticon e2 = endEmoticonsDraw.get(i);
      Emoticon e3 = new Emoticon (e1);
      if (frame>0) {
        e3.setTransPivotPos(new PVector(0, 0));
        e3.translate((e2.getX()-e3.getX())/totalFrame*frame, (e2.getY()-e3.getY())/totalFrame*frame);
        e3.scale(1+(e2.getRatio()/e3.getRatio()-1)*frame/totalFrame);
  
        for (int j= 0; j<4; j++) {
          PVector e2j = e2.getEndPivotPos().get(j);
          PVector e3j = e3.getEndPivotPos().get(j);
          e3.setManiPivotPos(new PVector(e3j.x+(e2j.x-e3j.x)/totalFrame*(frame-flow), e3j.y+(e2j.y-e3j.y)/totalFrame*(frame-flow)));
          if (e2j.x-e3j.x != 0 && e2j.y-e3j.y != 0) {
            e3.manipulateInverse(e3j.x+(e2j.x-e3j.x)/totalFrame*frame, e3j.y+(e2j.y-e3j.y)/totalFrame*frame, j);
          }
        }
      }
      
      if (frame > totalFrame || frame < 1) {
        flow *= -1;
        frame += flow;
      } else {
        frame += flow;
      }
      
      tempEmoticons.add(e3);
    }
    
    resultEmoticons = new ArrayList<Emoticon> (tempEmoticons);
  }
  
  public void run () {
    while (true) {
      if (startEmoticonsDraw.size()>0 && endEmoticonsDraw.size()>0 &&
      endEmoticonsDraw.size() == startEmoticonsDraw.size()) {
        animate();
        try {
        Thread.sleep(20);
      } catch (Exception e) {}
      }
    }
  }

  void resetFrame() {
    frame = 0;
  }
}




class Text {
  private String text;
  private int x, y;
  private float ratio;
  private boolean isTrans;

  Text() {
    this.text = "";
    this.ratio = 14*min(width, height)/20/3/3;
    this.isTrans = false;
  }
  void setText(String text) {
    this.text= text;
  }
  void setTextPos(int mx, int my) {
    this.x = mx;
    this.y = my;
  }

  void drawText() {
    textAlign(CENTER, CENTER);
    textFont(text_font, ratio);
    fill(0);
    text(text, x, y);
  }

  void pgDrawText(PGraphics pg) {
    pg.textAlign(CENTER, CENTER);
    pg.textFont(text_font, ratio);
    pg.fill(0);
    pg.text(text, x, y);
  }

  boolean isOver(int mx, int my) {
    if (mx<x-ratio/1.5*text.length() || mx>x+ratio/1.5*text.length()) return false;
    if (my<y-ratio/1.5 || my>y+ratio/1.5) return false;
    return true;
  }
  
  String getText() {
    return text;
  }
  
  boolean getIsTrans() {
    return isTrans;
  }
  
  void setIsTrans(boolean isTrans) {
    this.isTrans = isTrans; 
  }
}

class EmoticonFactory {
  private ArrayList<Emoticon> emoticons;
  private XML xml;

  EmoticonFactory () {
    emoticons = new ArrayList<Emoticon>();
  }

  void loadXMLfile(String fileName) {
    xml = loadXML(fileName);
    XML[] children = xml.getChildren("emoticon");
    for (int i =0; i < children.length; i++) {
      String name = children[i].getString("name");
      String filename = children[i].getString("filename");
      float w = children[i].getChild("width").getFloatContent();
      float h = children[i].getChild("height").getFloatContent();

      String[] posArray = {"lLegPivotPos", "rLegPivotPos", "lArmPivotPos", "rArmPivotPos", 
        "bodyPivotPos", "facePivotPos"};
      ArrayList<PVector> posPVectorArray = new ArrayList<PVector>();
      for (String pos : posArray) {
        float x = children[i].getChild(pos+"X").getFloatContent();
        float y = children[i].getChild(pos+"Y").getFloatContent();
        PVector posPVector = new PVector(x, y);
        posPVectorArray.add(posPVector);
      }
      emoticons.add(new Emoticon(name, filename, w, h, posPVectorArray));
    }
  }

  ArrayList<Emoticon> getEmoticons() {
    return emoticons;
  }
}

class Emoticon {
  //lLegPivotPos, rLegPivotPos, lArmPivotPos, rArmPivotPos
  private ArrayList<PVector> startPivotPos;
  private ArrayList<PVector> middlePivotPos;
  private ArrayList<PVector> endPivotPos;
  private PVector bodyPivotPos;
  private PVector facePivotPos;
  private PVector maniPivotPos;
  private PVector transPivotPos;
  private float w, h;
  private int x, y;
  private String name;
  private float ratio;
  private String filename;
  private PImage img;
  private boolean[] isMani;
  private boolean isTrans;
  private String expFilename;
  private PImage expImg;


  Emoticon (String name, String filename, float w, float h, ArrayList<PVector> startPivotPos) {
    this.name = name; 
    this.filename = filename;
    this.img = loadImage(this.filename);
    this.w = w;
    this.h = h;
    this.ratio = 14*min(width, height)/20/3;
    this.x = width/2;
    this.y = 13*height/40;
    this.startPivotPos = new ArrayList<PVector>();
    for (int i=0; i<4; i++) {
      this.startPivotPos.add(new PVector(x+startPivotPos.get(i).x/w*ratio, y+startPivotPos.get(i).y/w*ratio));
    }
    this.bodyPivotPos = new PVector(x+startPivotPos.get(4).x/w*ratio, y+startPivotPos.get(4).y/w*ratio);
    this.facePivotPos = new PVector(x+startPivotPos.get(5).x/w*ratio, y+startPivotPos.get(5).y/w*ratio);
    this.middlePivotPos = new ArrayList<PVector>();
    this.middlePivotPos.add(new PVector(this.startPivotPos.get(0).x, this.startPivotPos.get(0).y+ratio/5));
    this.middlePivotPos.add(new PVector(this.startPivotPos.get(1).x, this.startPivotPos.get(1).y+ratio/5));
    this.middlePivotPos.add(new PVector(this.startPivotPos.get(2).x+ratio/5, this.startPivotPos.get(2).y+ratio/5));
    this.middlePivotPos.add(new PVector(this.startPivotPos.get(3).x-ratio/5, this.startPivotPos.get(3).y+ratio/5));
    this.endPivotPos = new ArrayList<PVector>();
    this.endPivotPos.add(new PVector(this.startPivotPos.get(0).x, this.startPivotPos.get(0).y+ratio/2.5));
    this.endPivotPos.add(new PVector(this.startPivotPos.get(1).x, this.startPivotPos.get(1).y+ratio/2.5));
    this.endPivotPos.add(new PVector(this.startPivotPos.get(2).x+ratio/2.5, this.startPivotPos.get(2).y+ratio/2.5));
    this.endPivotPos.add(new PVector(this.startPivotPos.get(3).x-ratio/2.5, this.startPivotPos.get(3).y+ratio/2.5));
    isMani = new boolean[4];
    for (int i = 0; i<4; i++) {
      isMani[i] = false;
    }
    isTrans = false;
  }

  Emoticon (Emoticon other) {
    this.startPivotPos = new ArrayList<PVector>(other.startPivotPos);
    this.middlePivotPos = new ArrayList<PVector>(other.middlePivotPos);
    this.endPivotPos = new ArrayList<PVector>(other.endPivotPos);
    this.bodyPivotPos = new PVector(other.bodyPivotPos.x, other.bodyPivotPos.y);
    this.facePivotPos = new PVector(other.facePivotPos.x, other.facePivotPos.y);
    this.w = other.w;
    this.h = other.h;
    this.x = other.x;
    this.y = other.y;
    this.name = other.name;
    this.ratio = other.ratio;
    this.filename = other.filename;
    this.img = loadImage(filename);
    this.isMani = other.isMani;
    this.isTrans = other.isTrans;
    this.expFilename = other.expFilename;
    this.expImg = loadImage(expFilename);
  }

  void draw() {
    imageMode(CENTER);
    image(img, x, y, ratio, h/w*ratio);
    for (int i=0; i<4; i++) {
      noFill();
      stroke(0);
      strokeWeight(4);
      beginShape();
      vertex(startPivotPos.get(i).x, startPivotPos.get(i).y);
      quadraticVertex(middlePivotPos.get(i).x, middlePivotPos.get(i).y, endPivotPos.get(i).x, endPivotPos.get(i).y);
      endShape();  
      fill(0);
      ellipse(endPivotPos.get(i).x, endPivotPos.get(i).y, ratio/15, ratio/15);
    }
  }

  void pgDraw(PGraphics pg) {
    pg.imageMode(CENTER);
    pg.image(img, x, y, ratio, h/w*ratio);
    for (int i=0; i<4; i++) {
      pg.noFill();
      pg.stroke(0);
      pg.strokeWeight(4);
      pg.beginShape();
      pg.vertex(startPivotPos.get(i).x, startPivotPos.get(i).y);
      pg.quadraticVertex(middlePivotPos.get(i).x, middlePivotPos.get(i).y, endPivotPos.get(i).x, endPivotPos.get(i).y);
      pg.endShape();  
      pg.fill(0);
      pg.ellipse(endPivotPos.get(i).x, endPivotPos.get(i).y, ratio/15, ratio/15);
    }
  }

  void setExpression(String filename) {
    this.expFilename = filename;
    this.expImg = loadImage(filename);
  }

  void drawExpression() {
    imageMode(CENTER);
    image(expImg, facePivotPos.x, facePivotPos.y, ratio/3, h/w*ratio/3);
  }

  void pgDrawExpression(PGraphics pg) {
    pg.imageMode(CENTER);
    pg.image(expImg, facePivotPos.x, facePivotPos.y, ratio/3, h/w*ratio/3);
  }

  void manipulate(float mx, float my, int i) {
    float dx = mx-maniPivotPos.x;
    float dy = my-maniPivotPos.y;

    float distance = sqrt(dx*dx+dy*dy);

    float a= ratio/5;
    float b = ratio/5;
    float c = min(distance, a+b);

    float b1 = (b*b-a*a-c*c)/(-2*a*c);
    float c1 = (c*c-a*a-b*b)/(-2*a*b);

    if (b1>1.0) {
      b1=1.0;
    } else if (b1<-1.0) {
      b1=-1.0;
    }

    if (c1>1.0) {
      c1=1.0;
    } else if (c1<-1.0) {
      c1=-1.0;
    }

    float B = (1-2*(i%2))*acos(b1);
    float C = (1-2*(i%2))*acos(c1);
    float D = atan2(dy, dx);
    float E = D+B+C+PI;

    float ex = (cos(E) * a) + startPivotPos.get(i).x;
    float ey = (sin(E) * a) + startPivotPos.get(i).y;
    //print("UpperArm Angle=  "+degrees(E)+"    ");

    float hx = (cos(D+B) * b) + ex;
    float hy = (sin(D+B) * b) + ey;
    //println("LowerArm Angle=  "+degrees((D+B)));

    middlePivotPos.set(i, new PVector(ex, ey));
    endPivotPos.set(i, new PVector(hx, hy));
  }

  void manipulateInverse(float hx, float hy, int i) {
    float dx = hx-maniPivotPos.x;
    float dy = hy-maniPivotPos.y;

    float distance = sqrt(dx*dx+dy*dy);

    float a= ratio/5;
    float b = ratio/5;
    float c = min(distance, a+b);

    float b1 = (b*b-a*a-c*c)/(-2*a*c);
    float c1 = (c*c-a*a-b*b)/(-2*a*b);

    if (b1>1.0) {
      b1=1.0;
    } else if (b1<-1.0) {
      b1=-1.0;
    }

    if (c1>1.0) {
      c1=1.0;
    } else if (c1<-1.0) {
      c1=-1.0;
    }

    float B = (1-2*(i%2))*acos(b1);
    float C = (1-2*(i%2))*acos(c1);
    float D = atan2(dy, dx);
    float E = D+B+C+PI;

    float ex = (cos(E) * a) + startPivotPos.get(i).x;
    float ey = (sin(E) * a) + startPivotPos.get(i).y;
    //print("UpperArm Angle=  "+degrees(E)+"    ");

    middlePivotPos.set(i, new PVector(ex, ey));
    endPivotPos.set(i, new PVector(hx, hy));
  }

  void scale(float s) {
    this.ratio = this.ratio*s;

    facePivotPos = new PVector((facePivotPos.x-x)*s+x, (facePivotPos.y-y)*s+y);

    for (int i=0; i<4; i++) {
      this.startPivotPos.set(i, new PVector((startPivotPos.get(i).x-x)*s+x, (startPivotPos.get(i).y-y)*s+y));
    }

    this.middlePivotPos.set(0, new PVector((this.middlePivotPos.get(0).x-x)*s+x, (this.middlePivotPos.get(0).y-y)*s+y));
    this.middlePivotPos.set(1, new PVector((this.middlePivotPos.get(1).x-x)*s+x, (this.middlePivotPos.get(1).y-y)*s+y));
    this.middlePivotPos.set(2, new PVector((this.middlePivotPos.get(2).x-x)*s+x, (this.middlePivotPos.get(2).y-y)*s+y));
    this.middlePivotPos.set(3, new PVector((this.middlePivotPos.get(3).x-x)*s+x, (this.middlePivotPos.get(3).y-y)*s+y));

    this.endPivotPos.set(0, new PVector((this.endPivotPos.get(0).x-x)*s+x, (this.endPivotPos.get(0).y-y)*s+y));
    this.endPivotPos.set(1, new PVector((this.endPivotPos.get(1).x-x)*s+x, (this.endPivotPos.get(1).y-y)*s+y));
    this.endPivotPos.set(2, new PVector((this.endPivotPos.get(2).x-x)*s+x, (this.endPivotPos.get(2).y-y)*s+y));
    this.endPivotPos.set(3, new PVector((this.endPivotPos.get(3).x-x)*s+x, (this.endPivotPos.get(3).y-y)*s+y));
  }

  void translate(int mx, int my) {
    int dx = int(mx-transPivotPos.x);
    int dy = int(my-transPivotPos.y);

    this.x = this.x+dx;
    this.y = this.y+dy;

    facePivotPos = new PVector(facePivotPos.x+dx, facePivotPos.y+dy);

    for (int i=0; i<4; i++) {
      this.startPivotPos.set(i, new PVector(startPivotPos.get(i).x+dx, startPivotPos.get(i).y+dy));
    }

    this.middlePivotPos.set(0, new PVector(this.middlePivotPos.get(0).x+dx, this.middlePivotPos.get(0).y+dy));
    this.middlePivotPos.set(1, new PVector(this.middlePivotPos.get(1).x+dx, this.middlePivotPos.get(1).y+dy));
    this.middlePivotPos.set(2, new PVector(this.middlePivotPos.get(2).x+dx, this.middlePivotPos.get(2).y+dy));
    this.middlePivotPos.set(3, new PVector(this.middlePivotPos.get(3).x+dx, this.middlePivotPos.get(3).y+dy));

    this.endPivotPos.set(0, new PVector(this.endPivotPos.get(0).x+dx, this.endPivotPos.get(0).y+dy));
    this.endPivotPos.set(1, new PVector(this.endPivotPos.get(1).x+dx, this.endPivotPos.get(1).y+dy));
    this.endPivotPos.set(2, new PVector(this.endPivotPos.get(2).x+dx, this.endPivotPos.get(2).y+dy));
    this.endPivotPos.set(3, new PVector(this.endPivotPos.get(3).x+dx, this.endPivotPos.get(3).y+dy));
  }

  boolean isOverPivot(int mx, int my, int i) {
    if (mx<endPivotPos.get(i).x-14*min(width, height)/20/3/5 || mx>endPivotPos.get(i).x+14*min(width, height)/20/3/5) return false;
    if (my<endPivotPos.get(i).y-14*min(width, height)/20/3/5 || my>endPivotPos.get(i).y+14*min(width, height)/20/3/5) return false;
    return true;
  }

  boolean isOver(int mx, int my) {
    if (mx<x-ratio/2 || mx>x+ratio/2) return false;
    if (my<y-h/w*ratio/2 || my>y+h/w*ratio/2) return false;
    return true;
  }
  
  PImage getExpImg() {
    return expImg;
  }
  
  PVector getManiPivotPos() {
    return maniPivotPos;
  }
  
  PVector getTransPivotPos() {
    return transPivotPos;
  }
  
  void setManiPivotPos(PVector maniPivotPos) {
    this.maniPivotPos = maniPivotPos;
  }
  
  void setTransPivotPos(PVector transPivotPos) {
    this.transPivotPos = transPivotPos;
  }
  
  boolean[] getIsMani() {
    return isMani;
  }
  
  boolean getIsMani(int i) {
    return isMani[i];
  }
  
  void setIsMani(boolean[] isMani) {
    this.isMani = isMani;
  }
  
  void setIsMani(int i, boolean isMani) {
    this.isMani[i] = isMani;
  }
  
  boolean getIsTrans() {
    return isTrans;
  }
  
  void setIsTrans(boolean isTrans) {
    this.isTrans = isTrans;
  }
  
  String getName() {
    return name;
  }
  
  int getX() {
    return x;
  }
  
  int getY() {
    return y;
  }
  
  float getRatio() {
    return ratio;
  }
  
  ArrayList<PVector> getEndPivotPos() {
    return endPivotPos;
  }
}

class eDisplay {
  Emoticon emoticon;
  int w, h; 
  int left, right, top, bottom;
  int x, y;


  eDisplay(int x, int y, int w, int h) {
    this.w = 17*w/20;
    this.h = 3*h/8;
    this.x = x;
    this.y = y;
  }

  void draw() {
    noStroke();
    fill(255);
    rectMode(CENTER);
    rect(x, y, w, h, w/20);
  }

  void pgDraw(PGraphics pg) {
    pg.noStroke();
    pg.fill(255);
    pg.rectMode(CENTER);
    pg.rect(x, y, w, h, w/20);
  }

  boolean isOver(int mx, int my) {
    if (mx<x-w/2 || mx>x+w/2) return false;
    if (my<y-h/2 || my>y+h/2) return false;
    return true;
  }
}

class ExpressionFactory {
  private ArrayList<Expression> expressions;
  private XML xml;

  ExpressionFactory () {
    expressions = new ArrayList<Expression>();
  }

  void loadXMLfile(String fileName) {
    xml = loadXML(fileName);
    XML[] children = xml.getChildren("expression");
    for (int i =0; i < children.length; i++) {
      String name = children[i].getString("name");
      String filename = children[i].getString("filename");
      float w = children[i].getChild("width").getFloatContent();
      float h = children[i].getChild("height").getFloatContent();

      expressions.add(new Expression(name, filename, w, h, 
        (min(width, height)-3*min(width, height)/20)/3*(i%3)+3*width/40+14*width/20/3/2, 
        7*height/10+int((i%6)/3)*3*height/20, 14*min(width, height)/20/3));
    }
  }

  ArrayList<Expression> getExpressions() {
    return expressions;
  }
}

class Expression {
  private String name;
  private String filename;
  private PImage img;
  private float w, h;
  private int x, y;
  private int initX, initY;
  private float ratio;

  Expression (String name, String filename, float w, float h, int x, int y, float ratio) {
    this.name = name; 
    this.filename = filename;
    this.img = loadImage(filename);
    this.w = w;
    this.h = h;
    this.x = x;
    this.initX = x;
    this.y = y;
    this.initY = y;
    this.ratio = ratio;
  }

  void draw() {
    imageMode(CENTER);
    image(img, x, y, ratio, h/w*ratio);
  }

  boolean isOver(int mx, int my) {
    if (mx<x-ratio/2 || mx>x+ratio/2) return false;
    if (my<y-h/w*ratio/2 || my>y+h/w*ratio/2) return false;
    return true;
  }
  
  void setPos(int mx, int my) {
    x = mx;
    y = my;
  }
  
  int getInitX() {
    return initX;
  }
  
  int getInitY() {
    return initY;
  }
}

class CharacterFactory {
  private ArrayList<Character> characters;
  private XML xml;

  CharacterFactory () {
    characters = new ArrayList<Character>();
  }

  void loadXMLfile(String fileName) {
    xml = loadXML(fileName);
    XML[] children = xml.getChildren("character");
    for (int i =0; i < children.length; i++) {
      String name = children[i].getString("name");
      String filename = children[i].getString("filename");
      float w = children[i].getChild("width").getFloatContent();
      float h = children[i].getChild("height").getFloatContent();

      characters.add(new Character(name, filename, w, h, 
        (min(width, height)-3*min(width, height)/20)/3*(i%3)+3*width/40+14*width/20/3/2, 
        7*height/10+int((i%6)/3)*3*height/20, 14*min(width, height)/20/3));
    }
  }

  ArrayList<Character> getCharacters() {
    return characters;
  }
}

class Character {
  private String name;
  private String filename;
  private PImage img;
  private float w, h;
  private int x, y;
  private int initX, initY;
  private float ratio;

  Character(String name, String filename, float w, float h, int x, int y, float ratio) {
    this.name = name; 
    this.filename = filename;
    this.img = loadImage(this.filename);
    this.w = w;
    this.h = h;
    this.x = x;
    this.initX = x;
    this.y = y;
    this.initY = y;
    this.ratio = ratio;
  }

  void draw() {
    imageMode(CENTER);
    image(img, x, y, ratio, h/w*ratio);
  }

  boolean isOver(int mx, int my) {
    if (mx<x-ratio/2 || mx>x+ratio/2) return false;
    if (my<y-h/w*ratio/2 || my>y+h/w*ratio/2) return false;
    return true;
  }
  
  String getName() {
    return name;
  }
  
  void setPos(int mx, int my) {
    x = mx;
    y = my;
  }
  
  int getInitX() {
    return initX;
  }
  
  int getInitY() {
    return initY;
  }
}

class cStorage {
  cStorage() {
  }

  void draw() {
    noStroke();
    fill(232, 110, 107);
    rectMode(CORNER);
    rect(0, 11*height/20, width, 9*height/20);
  }
}

abstract class Button {
  protected int x, y;
  protected color col;


  Button (int x, int y, color col) {
    this.x = x;
    this.y = y;
    this.col = col;
  }

  Button (int x, int y) {
    this.x = x;
    this.y = y;
  }

  abstract void draw();
  abstract boolean isOver(int mx, int my);
}

class RectButton extends Button {
  private int w, h;
  private String name;

  RectButton(int x, int y, int w, int h, color col, String name) {
    super(x, y, col);
    this.w = w;
    this.h = h;
    this.name = name;
  }

  void draw() {
    noStroke();
    fill(super.col);
    rectMode(CENTER);
    rect(super.x, super.y, w, h, w/20);
    textAlign(CENTER, CENTER);
    textFont(inter_font, h/2);
    fill(255);
    text(name, x, y);
  }

  boolean isOver(int mx, int my) {
    if (mx<super.x-w/2 || mx>super.x+w/2) return false;
    if (my<super.y-h/2 || my>super.y+h/2) return false;
    return true;
  }
}

class ArrowButton extends Button {
  private int w, h;
  private String filename;
  private PImage arrow;

  ArrowButton(int x, int y, int w, int h) {
    super(x, y);
    this.w = w;
    this.h = h;
    this.filename = "arrow.png";
    this.arrow = loadImage(filename);
  }

  void draw() {
    imageMode(CENTER);
    image(arrow, x, y, w, h);
  }

  boolean isOver(int mx, int my) {
    if (mx<super.x-w/2 || mx>super.x+w/2) return false;
    if (my<super.y-h/2 || my>super.y+h/2) return false;
    return true;
  }
}

class Shadow {
  int Y_AXIS = 1;
  int X_AXIS = 2;
  int x, y;
  float w, h;
  color c1, c2;
  int axis;

  Shadow (int x, int y, float w, float h, color c1, color c2, int axis ) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.c1 = c1;
    this.c2 = c2;
    this.axis = axis;
  }

  void draw() {
    noFill();
    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = y; i <= y+h-1; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x+w, i);
      }
    } else if (axis == X_AXIS) {  // Left to right gradient
      for (int i = x; i <= x+w-1; i++) {
        float inter = map(i, x, x+w, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(i, y, i, y+h);
      }
    }
  }
}

public boolean surfaceTouchEvent(MotionEvent event) {
  super.surfaceTouchEvent(event);
  return gesture.surfaceTouchEvent(event);
}

void onPinch(float x, float y, float d)
{  
  if (emoji.mode != Mode.START && emoji.mode != Mode.ADD_TEXT && emoji.mode != Mode.SAVE) {
    if (d>10) { 
      for (Emoticon e : emoji.emoticonsDraw) {
        if (e.isOver(int(x), int(y))) {
          e.isTrans = false;
          float scale = map(d, 0, width, 1, 2);
          e.scale(scale);
        }
      }
    } else if (d<=-10) {
      for (Emoticon e : emoji.emoticonsDraw) {
        if (e.isOver(int(x), int(y))) {
          e.isTrans = false;
          float scale = map(d, -width, 0, 0, 1);
          e.scale(scale);
        }
      }
    }
  }
}

void showVirtualKeyboard()
{
  InputMethodManager imm = (InputMethodManager) getActivity().getSystemService(Context.INPUT_METHOD_SERVICE);
  imm.toggleSoftInput(InputMethodManager.SHOW_FORCED, 0);
}

void hideVirtualKeyboard()
{
  InputMethodManager imm = (InputMethodManager) getActivity().getSystemService(Context.INPUT_METHOD_SERVICE);
  imm.toggleSoftInput(InputMethodManager.HIDE_IMPLICIT_ONLY, 0);
}