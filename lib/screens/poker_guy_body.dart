import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:poker_guy/models/app_user.dart';
import 'package:poker_guy/models/poker_table.dart';
import 'package:poker_guy/models/table_player_names.dart';
import 'package:poker_guy/screens/open_table_widget.dart';
import 'package:poker_guy/services/database.dart';
import 'package:poker_guy/shared/loading.dart';
import 'package:poker_guy/screens/at_table_widget.dart';
import 'package:provider/provider.dart';
import 'join_table_widget.dart';
import 'start_screen_widget.dart';

class PokerGuyBody extends StatefulWidget {
  @override
  _PokerGuyBodyState createState() => _PokerGuyBodyState();
}

class _PokerGuyBodyState extends State<PokerGuyBody> {
  @override
  Widget build(BuildContext context) {
    // There should be a valid AppUser at this point.
    try {
      AppUser appUser = Provider.                                                                of<AppUser>(context);
      if (appUser == null) {
        return Loading();
      }

      if (appUser.playerState == PlayerState.idle) {
        return StartScreenWidget();
      }

      if (appUser.playerState == PlayerState.joiningTable) {
        return JoinTableWidget();
      }
      String tableId = appUser.tableId;

      if (tableId == null || tableId == "") {
        // We can't build any of the rest of the widgets
        // until we have a valid table id.
        return Loading();
      }

      Widget w = new Container();

      if (appUser.playerState == PlayerState.openingTable) {
        w = OpenTableWidget();
      } else if (appUser.playerState == PlayerState.atTable) {
        w = AtTableWidget();
      }

      return MultiProvider(
        providers: [
          StreamProvider<PokerTable>.value(
              value: DatabaseService(tableId: tableId).table),
          StreamProvider<TablePlayerNames>.value(
              value: DatabaseService(tableId: tableId).tablePlayers),
        ],
        child: w,
      );
    } on FirebaseFunctionsException catch (e) {
      print('poker guy body caught firebase functions exception');
      print(e.code);
      print(e.message);
      print(e.details);
    } on PlatformException catch (e) {
      print(e.message);
      print(e.details);
    } catch (e) {
      print('caught generic exception');
      print(e);
    }
  }
}
