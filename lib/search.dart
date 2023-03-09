import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/search_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = context.select((SearchBloc bloc) => bloc.state.users);
    return Scaffold(
      body: Column(
        children: [
          const Text('Search'),
          const SizedBox(height: 20),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Search here',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              context.read<SearchBloc>().add(SearchUserEvent(value));
            },
          ),
          if (users.isNotEmpty)
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(users[index]['username']),
                  );
                },
                itemCount: users.length,
              ),
            ),
        ],
      ),
    );
  }
}
