import 'package:flutter/material.dart';

import '../../models/fcf_standing.dart';
import '../../services/fcf_api_service.dart';

class LeagueTestScreen extends StatefulWidget {
  const LeagueTestScreen({super.key});

  @override
  State<LeagueTestScreen> createState() => _LeagueTestScreenState();
}

class _LeagueTestScreenState extends State<LeagueTestScreen> {
  late Future<List<FcfStanding>> standingsFuture;

  @override
  void initState() {
    super.initState();

    standingsFuture = FcfApiService.getClassification(
      '58161912',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0D12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF15131A),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Clasificación',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: FutureBuilder<List<FcfStanding>>(
        future: standingsFuture,
        builder: (context, snapshot) {
          // Cargando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            );
          }

          // Error
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No se pudo cargar la clasificación',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${snapshot.error}',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 13,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          standingsFuture =
                              FcfApiService.getClassification(
                            '58161912',
                          );
                        });
                      },
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            );
          }

          final standings = snapshot.data ?? [];

          if (standings.isEmpty) {
            return const Center(
              child: Text(
                'No hay datos de clasificación',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            );
          }

          return Column(
            children: [
              // Cabecera de estadísticas
              _buildHeader(),

              // Clasificación
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 20,
                  ),
                  itemCount: standings.length,
                  itemBuilder: (context, index) {
                    final team = standings[index];

                    return _buildTeamRow(
                      team,
                      index,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1B1921),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(14),
          topRight: Radius.circular(14),
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.06),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 35,
            child: Text(
              'POS',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Expanded(
            child: Text(
              'EQUIPO',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          _headerText('PJ'),
          _headerText('G'),
          _headerText('E'),
          _headerText('P'),
          _headerText('GF'),
          _headerText('GC'),

          const SizedBox(
            width: 45,
            child: Text(
              'PTS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerText(String text) {
    return SizedBox(
      width: 30,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white54,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTeamRow(
    FcfStanding team,
    int index,
  ) {
    final isTop = index < 4;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 1,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 13,
      ),
      decoration: BoxDecoration(
        color: index % 2 == 0
            ? const Color(0xFF15131A)
            : const Color(0xFF1A181F),
        border: Border(
          left: BorderSide(
            color: isTop
                ? Colors.red
                : Colors.transparent,
            width: 3,
          ),
        ),
      ),
      child: Row(
        children: [
          // POSICIÓN
          SizedBox(
            width: 32,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                color: isTop
                    ? Colors.red
                    : Colors.white70,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // EQUIPO
          Expanded(
            child: Row(
              children: [
                // Escudo
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFF24212A),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.08),
                    ),
                  ),
                  child: const Icon(
                    Icons.shield,
                    color: Colors.white38,
                    size: 18,
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: Text(
                    team.teamName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // PJ
          _statText('${team.played}'),

          // G
          _statText('${team.won}'),

          // E
          _statText('${team.drawn}'),

          // P
          _statText('${team.lost}'),

          // GF
          _statText('${team.goalsFor}'),

          // GC
          _statText('${team.goalsAgainst}'),

          // PUNTOS
          SizedBox(
            width: 45,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: isTop
                    ? Colors.red.withOpacity(0.15)
                    : const Color(0xFF24212A),
                borderRadius: BorderRadius.circular(7),
              ),
              child: Text(
                team.points.toStringAsFixed(0),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isTop
                      ? Colors.red
                      : Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statText(String value) {
    return SizedBox(
      width: 30,
      child: Text(
        value,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}