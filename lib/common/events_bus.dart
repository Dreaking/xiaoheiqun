import 'package:event_bus/event_bus.dart';
import 'package:xiaoheiqun/data/Draft.dart';

//Bus初始化
EventBus eventBus = EventBus();

class UserLoggedInEvent {
  String text;
  UserLoggedInEvent(String text) {
    this.text = text;
  }
}

class ShouCangInEvent {
  ShouCangInEvent() {}
}

class CaoClickInEvent {
  Draft draft;
  int id;
  CaoClickInEvent(Draft draft, int id) {
    this.draft = draft;
    this.id = id;
  }
}

class JoinChatEvent {
  int index;
  JoinChatEvent(int index) {
    this.index = index;
  }
}

class RinitView {
  RinitView() {}
}

//监听是否允许左右滑动
class setSlide {
  bool slide;
  setSlide(bool slide) {
    this.slide = slide;
  }
}
