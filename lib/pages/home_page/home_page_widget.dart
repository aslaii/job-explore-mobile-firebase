//lib/pages/home_page/home_page_widget.dart
import 'package:flutter/material.dart';
import '/components/headerlogo/headerlogo_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '../jobs/create_job_widget.dart';
import '../../services/job_service.dart';
import '../../models/job_model.dart';
import 'home_page_model.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({super.key});

  @override
  State<HomePageWidget> createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  late HomePageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _jobService = JobService();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreateJobWidget()),
            );
            setState(() {}); // Refresh the list after returning
          },
          backgroundColor: FlutterFlowTheme.of(context).primary,
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          title: wrapWithModel(
            model: _model.headerlogoModel,
            updateCallback: () => safeSetState(() {}),
            child: const HeaderlogoWidget(),
          ),
          actions: const [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: FutureBuilder<List<JobModel>>(
            future: _jobService.getJobs(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final jobs = snapshot.data ?? [];

              if (jobs.isEmpty) {
                return const Center(child: Text('No jobs posted yet'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    child: ListTile(
                      title: Text(
                        job.jobName,
                        style: FlutterFlowTheme.of(context).titleMedium,
                      ),
                      subtitle: Text(
                        '${job.company} - ${DateFormat('MMM d, yyyy').format(job.datePosted)}',
                        style: FlutterFlowTheme.of(context).bodySmall,
                      ),
                      onTap: () {
                        // Handle job selection
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
