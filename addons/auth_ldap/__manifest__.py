# Part of Odoo. See LICENSE file for full copyright and licensing details.

{
    'name': 'Authentication via LDAP',
    'depends': ['base'],
    #'description': < auto-loaded from README file
    'category': 'Tools',
    'data': [
        'views/ldap_installer_views.xml',
        'security/ir.model.access.csv',
    ],
    'application': True,
    'external_dependencies': {
        'python': ['pyldap'],
    }
}
