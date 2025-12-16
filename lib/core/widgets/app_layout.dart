import 'package:flutter/material.dart';

class AppLayout extends StatelessWidget {
  final Widget child;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onToggleCollapsed;
  final bool isCollapsed;

  const AppLayout({
    super.key,
    required this.selectedIndex,
    required this.onSelect,
    required this.onToggleCollapsed,
    required this.child,
    this.isCollapsed = false,
  });

  static const double _desktopBreakpoint = 800; // >= => desktop layout

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final isDesktop = w >= _desktopBreakpoint;

    if (!isDesktop) {
      // Mobile: Scaffold with Drawer
      return Scaffold(
        appBar: AppBar(
          title: const Text('User Dashboard'),
          leading: Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
        ),
        drawer: Drawer(
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 8),
                const ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person)),
                  title: Text('Admin'),
                  subtitle: Text('admin@example.com'),
                ),
                const Divider(),
                _DrawerItem(
                  icon: Icons.dashboard,
                  label: 'Dashboard',
                  onTap: () => onSelect(0),
                  selected: selectedIndex == 0,
                ),
                _DrawerItem(
                  icon: Icons.people,
                  label: 'Users',
                  onTap: () => onSelect(1),
                  selected: selectedIndex == 1,
                ),
                _DrawerItem(
                  icon: Icons.settings,
                  label: 'Customer Management',
                  onTap: () => onSelect(2),
                  selected: selectedIndex == 2,
                ),
                _DrawerItem(
                  icon: Icons.settings,
                  label: 'Settings',
                  onTap: () => onSelect(3),
                  selected: selectedIndex == 2,
                ),
                const Spacer(),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        body: child,
      );
    }

    // Desktop: Sidebar / collapsible
    return Scaffold(
      body: Row(
        children: [
          _Sidebar(
            collapsed: isCollapsed,
            selectedIndex: selectedIndex,
            onSelect: onSelect,
            onToggle: onToggleCollapsed,
          ),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _Sidebar extends StatefulWidget {
  final bool collapsed;
  final int selectedIndex;
  final ValueChanged<int> onSelect;
  final VoidCallback onToggle;

  const _Sidebar({
    required this.collapsed,
    required this.selectedIndex,
    required this.onSelect,
    required this.onToggle,
  });

  @override
  State<_Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<_Sidebar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anim;

  @override
  void initState() {
    super.initState();
    _anim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    if (!widget.collapsed) _anim.value = 1;
  }

  @override
  void didUpdateWidget(covariant _Sidebar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.collapsed) {
      _anim.reverse();
    } else {
      _anim.forward();
    }
  }

  @override
  void dispose() {
    _anim.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final collapsed = widget.collapsed;
    final width = collapsed ? 72.0 : 250.0;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      color: const Color.fromARGB(255, 255, 255, 255),
      child: Column(
        children: [
          const SizedBox(height: 12),
          // header with toggle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                if (!collapsed) const FlutterLogo(size: 36),
                if (!collapsed) const SizedBox(width: 8),
                Expanded(
                  child: FadeTransition(
                    opacity: _anim,
                    child: collapsed
                        ? const SizedBox.shrink()
                        : const Text(
                            'My Admin',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                IconButton(
                  tooltip: collapsed ? 'Expand' : 'Collapse',
                  icon: Icon(
                    collapsed ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                  ),
                  onPressed: widget.onToggle,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _navItem(Icons.dashboard, 'Dashboard', 0, collapsed),
                _navItem(Icons.people, 'Users', 1, collapsed),
                _navItem(Icons.people, 'Customer Management', 2, collapsed),
                _navItem(Icons.settings, 'Settings', 3, collapsed),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index, bool collapsed) {
    final selected = widget.selectedIndex == index;
    return InkWell(
      onTap: () => widget.onSelect(index),
      child: Container(
        color: selected ? Colors.blue.shade50 : Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          children: [
            Icon(icon, color: selected ? Colors.blue : Colors.black54),
            if (!collapsed) ...[
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.blue : Colors.black87,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: selected ? Colors.blue : null),
      title: Text(label),
      selected: selected,
      onTap: () {
        onTap();
        Navigator.maybePop(context); // close drawer on select
      },
    );
  }
}
