var google_analytics = `
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-135921114-1"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-135921114-6');
</script>
`;

var config = {
    site_title: 'Percona XtraDB MySQL Cluster Operator',

    analytics: google_analytics,

    variables: [
        {
            name: 'jupyterhub_namespace',
            content: process.env.JUPYTERHUB_NAMESPACE
        },
        {
            name: 'jupyterhub_application',
            content: process.env.JUPYTERHUB_APPLICATION
        }
    ]
};

module.exports = config;
