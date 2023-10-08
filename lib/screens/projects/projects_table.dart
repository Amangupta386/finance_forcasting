import 'package:ddofinance/providers/projects/projects_provider.dart';
import 'package:ddofinance/screens/projects/projects_column_headers.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ddofinance/utils/constants/images.dart';
import 'package:ddofinance/utils/master_data.dart';
import 'package:ddofinance/widgets/image_asset.dart';

/// A widget that displays a data table of projects.
class ProjectsTable extends StatelessWidget {
  const ProjectsTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Access the provider for projects data.
    ProjectsProvider provider = Provider.of<ProjectsProvider>(context);

    /// Access the theme and screen dimensions.
    ThemeData theme = Theme.of(context);
    MediaQueryData mQ = MediaQuery.of(context);
    double deviceWidth = mQ.size.width;
    final ColorScheme colorTheme = theme.colorScheme;

    return DataTable(
        columns: [
          for (var columnHeader in MasterData.projectTableColumnHeaders)
            DataColumn(

                ///[ProjectsColumnHeaderData] Displaying data table headers
                label: ProjectsColumnHeaderData(
              columnHeader: columnHeader,
            ))
        ],
        rows: List.generate(provider.filteredSearchBoxData.length, (int index) {
          return DataRow(cells: [
            DataCell(
                Text(
                  provider.filteredSearchBoxData[index].clientName,
                  style: theme.textTheme.bodyMedium,
                ), onTap: () {
              provider.filteredSearchBoxData[index].clientName;
              context.goNamed('projectChartScreen');

              provider.setProjectIndex(index);
              provider.setToMove(true);
            }),
            DataCell(Text(
              provider.filteredSearchBoxData[index].projectName,
              style: theme.textTheme.bodyMedium,
            )),
            DataCell(Text(
              provider.filteredSearchBoxData[index].projectForecast.toString(),
              style: theme.textTheme.bodyMedium,
            )),
            DataCell(Text(
              provider.filteredSearchBoxData[index].actualCost.toString(),
              style: theme.textTheme.bodyMedium,
            )),
            DataCell(
                //Displaying  color and data cell data according to status.
                provider.buildStatusRow(index, context)),
            DataCell(GestureDetector(
              onTap: () {
                ///Navigating to edit projects screen.
                provider.navigateToEditProjectScreen(context, index);
              },
              child: Row(
                children: [
                  ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: deviceWidth / 50),
                      child: const ImageAsset(imageName: Images.editIcon)),
                  Text(
                    'Edit',
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: colorTheme.onTertiary),
                  ),
                ],
              ),
            )),
          ]);
        }));
  }
}
