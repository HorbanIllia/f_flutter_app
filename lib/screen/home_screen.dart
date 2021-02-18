import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_flutter_app/bloc/posts_bloc/posts_bloc.dart';
import 'package:t_flutter_app/models/post.dart';
import 'package:t_flutter_app/screen/post_screen.dart';

class HomeScreen extends StatefulWidget  {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomeScreen> {
  final PostsBloc _newsBloc = PostsBloc();
  List<Post> _duplicateList = List<Post>();
  List<Post> model;
  TextEditingController editingController;

  @override
  void initState() {
    _newsBloc.add(GetPostsList());
    editingController = TextEditingController();
    super.initState();
  }

  void dispose() {
    editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(child: _buildListPosts()),
          ],
        ),
      ),
    );
  }

  void filterSearchResults(String query){
    var dummySearchList = _duplicateList.map((e) => e).toSet();

    if(query.isNotEmpty) {
      List<Post> dummyListData = List<Post>();
      dummyListData = dummySearchList
          .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
          .toList();

      setState(() {
        model.clear();
        model.addAll(dummyListData);

      });
      return;
    } else {
      setState(() {
        model.clear();
        model.addAll(dummySearchList);
      });
    }
  }

  Widget _buildListPosts() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<PostsBloc, PostsState>(
          listener: (context, state) {
            if (state is PostsError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is PostsInitial) {
                return _buildLoading();
              } else if (state is PostsLoading) {
                return _buildLoading();
              } else if (state is PostsLoaded) {
                _duplicateList.addAll(state.postModel);
                model = state.postModel;
                return RefreshIndicator(
                  child: _buildCard(context),
                  onRefresh: () async{
                    state.postModel.clear();
                    BlocProvider.of<PostsBloc>(context).add(GetPostsList(),);
                  },
                );
              } else if (state is PostsError) {
                return Container(
                  child: Text(state.message),
                );
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context) {

    return ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      children: [
        ExpansionPanelList.radio(
          children: model.map<ExpansionPanelRadio>((Post item) {
            return ExpansionPanelRadio(
              value: item.id,
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(item.title),
                );
              },
              body: ListTile(
                subtitle: Column(
                  children: <Widget>[
                    Text(item.body),
                    FlatButton(child: Text('Details'), onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => PostScreen(item)));
                    })
                  ],
                ),
              ),
            );
          }).toList(),
        )
      ],
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}