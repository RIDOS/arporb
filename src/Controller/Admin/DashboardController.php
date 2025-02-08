<?php

namespace App\Controller\Admin;

use App\Entity\User;
use App\Entity\News;
use EasyCorp\Bundle\EasyAdminBundle\Attribute\AdminDashboard;
use EasyCorp\Bundle\EasyAdminBundle\Config\Dashboard;
use EasyCorp\Bundle\EasyAdminBundle\Config\MenuItem;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractDashboardController;
use Symfony\Component\HttpFoundation\Response;

#[AdminDashboard(routePath: '/admin', routeName: 'admin')]
class DashboardController extends AbstractDashboardController
{
    public function index(): Response
    {
        // return parent::index();
        return $this->redirectToRoute('admin_user_index');
    }

    public function configureDashboard(): Dashboard
    {
        return Dashboard::new()
            ->setTitle('АРПОРБ')
            ->setLocales(['ru']);
    }

    public function configureMenuItems(): iterable
    {
        return [
            MenuItem::linkToDashboard('Welcome page', 'fa fa-home'),
            MenuItem::section('Actions with users'),
            MenuItem::linkToCrud('User', 'fa fa-user', User::class),
            MenuItem::section('Pages'),
            MenuItem::linkToCrud('News', 'fa fa-news', News::class),
        ];
    }
}
