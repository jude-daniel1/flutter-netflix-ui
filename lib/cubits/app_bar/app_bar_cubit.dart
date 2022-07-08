import 'package:bloc/bloc.dart';

class AppBarCubit extends Cubit<double> {
  AppBarCubit() : super(0);

  // double _scrollOffset = 0.0;
  void setOffset(double offset) => emit(offset);
}


//event --> bloc --> state-->render different ui
//block -->functions call -> state->ui