import graphviz

# Initialize the diagram
dot = graphviz.Digraph('MultiAppArchitecture', comment='Nginx Gunicorn Django React Stack')
dot.attr(rankdir='LR', size='12,8', fontname='Arial')

# Node styling defaults
dot.attr('node', shape='box', style='filled,rounded', fontname='Arial', fontsize='10')

# --- LEGEND ---
with dot.subgraph(name='cluster_legend') as l:
    l.attr(label='Legend', fontsize='12', style='dotted')
    l.node('l1', 'Systemd Daemon', fillcolor='#ff9999')
    l.node('l2', 'Systemd Socket', fillcolor='#ffcc00')
    l.node('l3', 'React (Static)', fillcolor='#c2f0c2')
    l.node('l4', 'Django (Logic)', fillcolor='#add8e6')

# --- CORE INFRASTRUCTURE ---
dot.node('User', 'User\n(Browser)', shape='ellipse', fillcolor='white')
dot.node('Nginx', 'Nginx\n(systemd daemon)', fillcolor='#ff9999')
dot.edge('User', 'Nginx', label=' HTTP/S')

# --- APPLICATION 1 ---
with dot.subgraph(name='cluster_app1') as c1:
    c1.attr(label='Application Stack 1', style='dashed', color='grey')
    c1.node('React1', 'React UI 1\n(Static Files)', fillcolor='#c2f0c2')
    c1.node('Socket1', 'systemd socket 1\n(/run/app1.sock)', fillcolor='#ffcc00')
    c1.node('Gunicorn1', 'Gunicorn 1\n(systemd daemon)', fillcolor='#ff9999')
    c1.node('Django1', 'Django 1\n(App Logic)', fillcolor='#add8e6')

    # Internal flow
    dot.edge('Nginx', 'React1', label=' direct serve', style='dotted')
    dot.edge('Nginx', 'Socket1', label=' proxy_pass')
    dot.edge('Socket1', 'Gunicorn1')
    dot.edge('Gunicorn1', 'Django1')

# --- APPLICATION 2 ---
with dot.subgraph(name='cluster_app2') as c2:
    c2.attr(label='Application Stack 2', style='dashed', color='grey')
    c2.node('React2', 'React UI 2\n(Static Files)', fillcolor='#c2f0c2')
    c2.node('Socket2', 'systemd socket 2\n(/run/app2.sock)', fillcolor='#ffcc00')
    c2.node('Gunicorn2', 'Gunicorn 2\n(systemd daemon)', fillcolor='#ff9999')
    c2.node('Django2', 'Django 2\n(App Logic)', fillcolor='#add8e6')

    # Internal flow
    dot.edge('Nginx', 'React2', label=' direct serve', style='dotted')
    dot.edge('Nginx', 'Socket2', label=' proxy_pass')
    dot.edge('Socket2', 'Gunicorn2')
    dot.edge('Gunicorn2', 'Django2')

# Render to file
dot.render('deployment_flowchart', format='png', cleanup=True)
print("Diagram generated as deployment_flowchart.png")
